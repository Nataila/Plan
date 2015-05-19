#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Nataila @ 2015-05-08

from django.conf.urls import patterns, url

urlpatterns = patterns('',
    url(r'^login/$', 'users.views.home', {'template': 'users/home.html'}, 'home'),
    url(r'^register/$', 'users.views.register', {'template': 'users/register.html'}, 'register'),
    url(r'^logout/$', 'users.views.logout_views', name='logout'),
    url(r'^valid_username/$', 'users.views.valid_username')
)
