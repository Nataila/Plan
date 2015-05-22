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
    """ 储存todo """
    if request.method == "GET":
        todo = Todo(
          user=request.user,
          content=params['content'],
          type=params['type'],
          status=False,
        )
        todo.save()
    last_data = Todo.objects.all()[0]
    content = {
        'status': 200,
        'id': last_data.id,
        'time': last_data.created_at.strftime("%Y-%m-%d %H:%M:%S")
        }
    return HttpResponse(json.dumps(content))

def get_default_data(request):
    """ 获取初始展示的数据 """

    print request.GET
    type = request.GET.get('type')
    if type:
        todo_list = Todo.objects.filter(type=type).values()
        return HttpResponse(simplejson.dumps(_parse_data(todo_list)))

def _parse_data(data):
    result_data = []
    for i in data:
        result_data.append({
            'id': i['id'],
            'content': i['content'],
            'type': i['type'],
            'status': i['status'],
            'time': i['created_at'].strftime("%Y-%m-%d %H:%M:%S")
        })
    return result_data

def change_status(request):
    """ 更改条目状态 """

    sid = int(request.GET.get('sid', ''))
    status = request.GET.get('status', False)
    if status == 'true':
        status = True
    else:
        status = False
    todo_data = Todo.objects.get(id=sid)
    todo_data.status = status
    todo_data.save()
    return HttpResponse({'status': 200})

def delete(request):
    """ 删除条目 """
    sid = int(request.GET.get('sid', ''))
    data = Todo.objects.get(id=sid)
    data.delete()
    return HttpResponse(json.dumps({'status': 200}))
