#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Nataila @ 2015-05-08

from django.db import models
from django.contrib.auth.models import User

class UserProfile(models.Model):
    """ 用户Profile表"""

    user = models.OneToOneField(User, unique=True)

    realname = models.CharField(max_length=150)

    class Meta:
        db_table = 'user_profile'
