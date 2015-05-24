#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Nataila @ 2015-05-17

from django.conf.urls import patterns, url

urlpatterns = patterns('',
    url(r'^$', 'todo.views.index', {'template': 'todo/index.html'}),
    url(r'^plan.html$', 'todo.views.plan', {'template': 'todo/plan.html'}),
    url(r'^report.html$', 'todo.views.report', {'template': 'todo/report.html'}),
    url(r'^plan/detail$', 'todo.views.detail', {'template': 'todo/plan-detail.html'}),
    url(r'^save$', 'todo.views.save'),
    url(r'^get_default_data$', 'todo.views.get_default_data'),
    url(r'^change_status$', 'todo.views.change_status'),
    url(r'^delete$', 'todo.views.delete'),
)
