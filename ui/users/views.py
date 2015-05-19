#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Nataila @ 2015-05-08

import json

from django.http import HttpResponse
from django.http import HttpResponseRedirect
from django.template.response import TemplateResponse
from django.contrib.auth import authenticate, login, logout


from forms import UserAddForm

def home(request, template):
    """ 首页 """

    if request.method == 'POST':
        print request.POST
        username = request.POST.get('username', '')
        passwd = request.POST.get('password', '')
        user = authenticate(username=username, password=passwd)
        if user is not None:
            login(request, user)
            return HttpResponseRedirect('/todo')
    content = {
        'request': request,
        'stat': 200
    }
    return TemplateResponse(request, template, content)


def register(request, template):
    """ 注册 """

    if request.method == 'POST':
        userinfo = json.loads(request.body)
        print userinfo
        userform = UserAddForm(userinfo)
        if userform.is_valid():
            userform.save()
            return HttpResponse(json.dumps({'status': 200}))
    content = {
        'request': request,
    }
    return TemplateResponse(request, template, content)


def valid_username(request):
    """ 校验用户名是否已经存在 """

    return HttpResponse({'name': 123123})


def logout_views(request):
    """ 登出 """

    logout(request)
    return HttpResponseRedirect('/accounts/login')
