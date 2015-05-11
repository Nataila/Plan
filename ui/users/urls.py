#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Nataila @ 2015-05-08

from django.conf.urls import patterns, url

urlpatterns = patterns('',
    url(r'^$', 'users.views.home', {'template': 'users/home.html'}, 'home'),
)
