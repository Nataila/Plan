#! /usr/bin/env python
# -*- coding: utf-8 -*_

from django.shortcuts import render
from django.template.response import TemplateResponse
from django.contrib.auth.decorators import login_required

@login_required
def index(request, template):
    return TemplateResponse(request, template, {"status": 200})
