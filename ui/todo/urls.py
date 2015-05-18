#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Nataila @ 2015-05-17

from django.conf.urls import patterns, url

urlpatterns = patterns('',
    url(r'^$', 'todo.views.index', {'template': 'todo/index.html'}),
    url(r'^day.html$', 'todo.views.day', {'template': 'todo/day.html'}),
    url(r'^plan.html$', 'todo.views.plan', {'template': 'todo/plan.html'}),
    url(r'^report.html$', 'todo.views.report', {'template': 'todo/report.html'}),
)
