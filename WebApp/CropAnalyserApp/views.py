
from django.shortcuts import render
from django.http import HttpResponse,JsonResponse


# Create your views here.

def home(request):

    # return HttpResponse('Welcome')
    return render(request,'CropAnalyserApp/home.html')