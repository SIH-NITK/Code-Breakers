
from django.shortcuts import render
from django.http import HttpResponse,JsonResponse

from django.views.decorators.csrf import csrf_exempt

from PIL import Image
import os
import cv2
import numpy as np
from datetime import datetime
import time
import pickle
import requests
import json

def get_season_details(date_dict):
    
    with open('crop_cycles.txt', 'rb') as fp:
        crop_cycles = pickle.load(fp)
    
    max_yr = 0; min_yr = 3000
    for cycle in crop_cycles:
        if(max_yr < cycle['end_date'].year):
            max_yr = cycle['end_date'].year
        if(min_yr > cycle['start_date'].year):
            min_yr = cycle['start_date'].year
    
    from_m = date_dict['starting_month']
    from_y = date_dict['starting_year']
    to_m = date_dict['end_month']
    to_y = date_dict['end_year']
    
    from_date = datetime.strptime('{d}/{m}/{y}'.format(d=15, m=from_m, y=from_y), '%d/%m/%Y')
    to_date = datetime.strptime('{d}/{m}/{y}'.format(d=15, m=to_m, y=to_y), '%d/%m/%Y')
    
    selected_crop_cycles = {}
    selected_crop_cycles['max_year'] = max_yr
    selected_crop_cycles['min_year'] = min_yr
    selected_crop_cycles['crop_cycle'] = []
    for cycle in crop_cycles:
        if((cycle['start_date'] > to_date) | (cycle['end_date'] < from_date)):
            pass
        else:
            selected_crop_cycles['crop_cycle'].append(cycle)
    
    return selected_crop_cycles

def determine_date(period1):
    y, m, half = period1.split('_')
    if(half=='1'):
        d = 1
    else:
        d = 16
    y = int(y)
    m = int(m)
    return d, m, y
    
def calculate_date(d, val1, val2):
    day_incr = int((-15 * val1) / (-val1 + val2))
    d += day_incr
    return d

def create_timeline(path_name):
    split = path_name.split('_')
    y, m, half = split[2][:4], split[2][4:], split[4]
    return '_'.join([y, m, half])

def generate_crop_cycles(dirname):
    img_file = os.listdir(dirname)
    img_x = int(2135*0.1)
    img_y = int(2118*0.1)
    imgs = np.zeros((48, 2135 - 2*img_x, 2118 - 2*img_y))
    for ind in range(48):
        img = Image.open(dirname + '/' + img_file[ind])
        img = np.asarray(img, dtype = np.uint8)
        imgs[ind] = img[img_x:-img_x, img_y:-img_y]
    timeline = [create_timeline(x) for x in img_file]
    
    imgs_var = np.var(imgs, axis = 0)
    var_max = imgs_var.max()
    var_thresh = var_max // 2
    imgs_var2 = np.asarray(imgs_var > var_thresh, dtype=np.uint8)

    imgs_var_final = cv2.morphologyEx(imgs_var2, cv2.MORPH_OPEN, np.ones((7,7)))
    imgs_var_final2 = cv2.dilate(imgs_var_final, np.ones((7,7)), iterations = 1)
    
    vals = np.zeros(48)
    for ind in range(48):
        mod_img = np.multiply(imgs[ind], imgs_var_final2)
        vals[ind] = np.sum(mod_img)
    val_diff = np.diff(vals)

    harvest = np.quantile(val_diff, 0.25)
    sowing = np.quantile(val_diff, 0.75)
    harvest_dates = {}
    sowing_dates = {}
    last_index = 0

    for ind in range(47):
        if((val_diff[ind]>0)&(val_diff[max(0,ind-1)]<0)):
            if(val_diff[last_index:max(1,ind)].min() < harvest):
                d, m, y = determine_date(timeline[1:][ind-1])
                d = calculate_date(d, val_diff[ind-1], val_diff[ind])
                sowing_dates[ind] = datetime.strptime("{d}/{m}/{y}".format(d=d, m=m, y=y), '%d/%m/%Y')
                last_index = ind
        if((val_diff[ind]<0)&(val_diff[min(47,ind-1)]>0)):
            if(val_diff[last_index:max(1,ind)].max() > sowing):
                d, m, y = determine_date(timeline[1:][ind-1])
                d = calculate_date(d, val_diff[ind-1], val_diff[ind])
                harvest_dates[ind] = datetime.strptime("{d}/{m}/{y}".format(d=d, m=m, y=y), '%d/%m/%Y')
                last_index = ind

    crop_cycles = []
    current_ind = -1
    crop_cycle_data = {}
    for ind in range(48):
        if(ind in sowing_dates):
            crop_cycle_data = {}
            crop_cycle_data['start_date'] = sowing_dates[ind]
            current_ind = ind
        if(ind in harvest_dates):
            if(current_ind != -1):
                crop_cycle_data['end_date'] = harvest_dates[ind]
                crop_cycle_data['yield'] = np.sum(vals[current_ind: ind])
                crop_cycle_data['imgs_path'] = img_file[current_ind: ind]
                current_ind = -1
                crop_cycles.append(crop_cycle_data)

    with open('crop_cycles.txt', 'wb') as fp:
        pickle.dump(crop_cycles, fp)

@csrf_exempt
def home(request):

    # return HttpResponse('Welcome')
    if request.method=="POST":

        from_date=str(request.POST.get('from_date'))
        to_date=str(request.POST.get('to_date'))
        print(from_date)
        # from_date=from_date.split()
        if from_date == "None":
            print('GET trigged')
            from_date=str(request.GET.get('from_date'))
            to_date=str(request.GET.get('to_date'))
        masking_method=request.POST.get('masking_method')

        from_date=from_date.split('-')
        to_date=to_date.split('-')
        print('((((((((((((((((((((((((((((((9))))))))))))))))))))))))))))))',from_date,to_date)
        dicti={
            'starting_month': from_date[1],
            'starting_year' : from_date[0],
            'end_month' : to_date[1],
            'end_year' : to_date[0]
        }
        print(dicti)
        if masking_method=="Self Select Farmland":

            #return different page
            return render(request,'CropAnalyserApp/home.html')
        
        else:
            # generate_crop_cycles('/home/shashank/SIH/Code-Breakers/WebApp/CropAnalyserApp/templates/CropAnalyserApp/Clipped_NDVI/')
            data_to_frontend = get_season_details(dicti)
            for i in range(len(data_to_frontend['crop_cycle'])):
                data_to_frontend['crop_cycle'][i]['start_date']=data_to_frontend['crop_cycle'][i]['start_date'].strftime("%Y/%m/%d")
                data_to_frontend['crop_cycle'][i]['end_date']=data_to_frontend['crop_cycle'][i]['end_date'].strftime("%Y/%m/%d")
            print('@@@@@@@@@111111111111111111',data_to_frontend)
            # json_data=json.dumps(data_to_frontend)
            # print()
            # print('@@@@@@@@@222222222222222222',json_data)
            # return HttpResponse(json_data)

            # json_loaded_data=json.loads(json_data)
            
            # json_data=json.dumps(data_to_frontend)
            # print(json_data)
            # json_loaded_data=json.loads(json_data)
            # print('@@@@@@@@@3333333333333333',json_loaded_data)
            # st = str(json_loaded_data)
            # print('@@@@@@@@@44444444444444444',st)            
            # return HttpResponse(json_data, content_type='application/json')
            # requests.get('http://localhost:8080',params=get_season_details(dict))



            return render(request,'CropAnalyserApp/analyze.html',{'data_to_frontend':data_to_frontend})

    return render(request,'CropAnalyserApp/home.html')

@csrf_exempt
def app_home(request):

    # return HttpResponse('Welcome')
    if request.method=="POST":

        from_date=str(request.POST.get('from_date'))
        to_date=str(request.POST.get('to_date'))
        print(from_date)
        if from_date == "None":
            print('GET trigged')
            from_date=str(request.GET.get('from_date'))
            to_date=str(request.GET.get('to_date'))
        masking_method=request.POST.get('masking_method')

        from_date=from_date.split('-')
        to_date=to_date.split('-')
        print('((((((((((((((((((((((((((((((9))))))))))))))))))))))))))))))',from_date,to_date)
        dicti={
            'starting_month': from_date[1],
            'starting_year' : from_date[2],
            'end_month' : to_date[1],
            'end_year' : to_date[2]
        }
        print(dicti)
        if masking_method=="Self Select Farmland":

            #return different page
            return render(request,'CropAnalyserApp/app_home.html')
        
        else:
            # generate_crop_cycles('/home/shashank/SIH/Code-Breakers/WebApp/CropAnalyserApp/templates/CropAnalyserApp/Clipped_NDVI/')
            data_to_frontend = get_season_details(dicti)
            for i in range(len(data_to_frontend['crop_cycle'])):
                data_to_frontend['crop_cycle'][i]['start_date']=data_to_frontend['crop_cycle'][i]['start_date'].strftime("%Y/%m/%d")
                data_to_frontend['crop_cycle'][i]['end_date']=data_to_frontend['crop_cycle'][i]['end_date'].strftime("%Y/%m/%d")
            print('@@@@@@@@@111111111111111111',data_to_frontend)
            json_data=json.dumps(data_to_frontend)
            # print()
            print('@@@@@@@@@222222222222222222',json_data)
            # return HttpResponse(json_data)

            # json_loaded_data=json.loads(json_data)
            
            # json_data=json.dumps(data_to_frontend)
            # print(json_data)
            # json_loaded_data=json.loads(json_data)
            # print('@@@@@@@@@3333333333333333',json_loaded_data)
            # st = str(json_loaded_data)
            # print('@@@@@@@@@44444444444444444',st)            
            return HttpResponse(json_data, content_type='application/json')
            # requests.get('http://localhost:8080',params=get_season_details(dict))



            # return render(request,'CropAnalyserApp/dashboard.html',{'data_to_frontend':data_to_frontend})

    return render(request,'CropAnalyserApp/app_home.html')
