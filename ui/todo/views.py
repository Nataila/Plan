#! /usr/bin/env python
# -*- coding: utf-8 -*_

from django.template.response import TemplateResponse
from django.contrib.auth.decorators import login_required

@login_required
def index(request, template):
    return TemplateResponse(request, template, {"status": 200})

@login_required
def day(request, template):
    return TemplateResponse(request, template, {"status": 200})

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
