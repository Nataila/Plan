#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Nataila @ 2015-05-08

from django.db import models
from django.contrib.auth.models import User

class Todo(models.Model):
    """ TODO LIST """
    TODO_TYPE = (
        (0, 'day'),
        (1, 'week'),
        (2, 'month')
    )

    user = models.ForeignKey(User)
    content = models.CharField(max_length=500, unique=True)
    status = models.BooleanField(default=False)  # 完成状态，完成为True，未完成为False
    created_at = models.DateTimeField(auto_now=True)
    type = models.CharField(max_length=20, choices=TODO_TYPE, default=0)

    class Meta:
        db_table = "todo"
        ordering = ['-created_at']
