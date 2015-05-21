#! /usr/bin/env python
# -*- coding: utf-8 -*_

import json

from django.utils import simplejson
from django.template.response import TemplateResponse
from django.http import HttpResponse
from django.contrib.auth.decorators import login_required

from models import Todo

@login_required
def index(request, template):
    return TemplateResponse(request, template, {"status": 200})

@login_required
def day(request, template):
    return TemplateResponse(request, template, {})

@login_required
def week(request, template):
    return TemplateResponse(request, template, {"status": 200})

@login_required
def month(request, template):
    return TemplateResponse(request, template, {"status": 200})

@login_required
def plan(request, template):
    return TemplateResponse(request, template, {"request": request, "status": 200})

@login_required
def report(request, template):
    return TemplateResponse(request, template, {"status": 500})

@login_required
def save(request):
    if request.method == "POST":
        params = json.loads(request.body)
        todo = Todo(
          user = request.user,
          content = params['content'],
          type = params['type'],
          status = 0,
        )
        todo.save()
    return HttpResponse({'status': 200})

def get_default_data(request):
    """ 获取初始展示的数据 """

    type = request.GET.get('type')
    if type:
        todo_list = Todo.objects.filter(type=type).values()
        return HttpResponse(simplejson.dumps(_parse_data(todo_list)))

def _parse_data(data):
    result_data = []
    for i in data:
        result_data.append({
            'content': i['content'],
            'type': i['type'],
            'status': i['status'],
            'time': i['created_at'].strftime("%Y-%m-%d %H:%M:%S")
        })
    return result_data
