#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Nataila @ 2015-05-08

from django.template.response import TemplateResponse
from forms import UserAddForm
def home(request, template):
    """ 首页 """
    content = {
        'request': request,
        'stat': 200
    }
    return TemplateResponse(request, template, content)

def register(request, template):
    """ 注册 """
    if request.method == 'POST':
        print request.POST
        userform = UserAddForm(request.POST)
        if userform.is_valid():
            print 200
            userform.save()
    content = {
        'request': request,
    }
    return TemplateResponse(request, template, content)
