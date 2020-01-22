from django.urls import path,include
from django.conf.urls import url

from . import views

urlpatterns = [

    url(r'^home$',views.home),
    url(r'^app_home$',views.app_home),
]