#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Nataila @ 2015-05-09

from django import forms
from django.contrib.auth.models import User

class UserAddForm(forms.Form):
    username = forms.CharField(label=u'用户名', max_length=100)
    password1 = forms.CharField(label=u'请输入密码', max_length=100)
    password2 = forms.CharField(label=u'请确认密码', max_length=100)
    email = forms.EmailField(label=u'电子邮箱')

    def save(self):
        user = User.objects.create_user(
            self.cleaned_data['username'].strip.lower(),
            self.cleaned_data['password1'],
            self.cleaned_data['email'].strip,
        )
        user.save()

        return user
