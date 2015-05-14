#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Nataila @ 2015-05-08

from django.template.response import TemplateResponse
from forms import UserAddForm
import json

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
        userinfo = json.loads(request.body)
        userform = UserAddForm(userinfo)
        if userform.is_valid():
            userform.save()
    content = {
        'request': request,
    }
    return TemplateResponse(request, template, content)
