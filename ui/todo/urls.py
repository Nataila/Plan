#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Nataila @ 2015-05-17

from django.conf.urls import patterns, url

urlpatterns = patterns('',
    url(r'^$', 'todo.views.index', {'template': 'todo/index.html'})
)
