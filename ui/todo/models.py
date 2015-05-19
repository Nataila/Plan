#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Nataila @ 2015-05-08

from django.db import models
from django.contrib.auth.models import User

class Todo(models.Model):
    """ TODO LIST """
    TODO_TYPE = (
        ('day', 'day'),
        ('week', 'week'),
        ('month', 'month')
    )

    user = models.OneToOneField(User, unique=True)
    content = models.CharField(max_length=500, unique=True)
    status = models.IntegerField()  # 完成状态，完成为1，未完成为0
    created_at = models.TimeField(auto_now=True)
    type = models.CharField(max_length=20, choices=TODO_TYPE, default='day')

    class Meta:
        db_table = "Todo"
        ordering = ['created_at']
