from django.conf.urls import patterns, include, url

from django.contrib import admin
from django.views.generic import RedirectView
admin.autodiscover()

urlpatterns = patterns('',
    # Examples:
    # url(r'^$', 'ui.views.home', name='home'),
    # url(r'^blog/', include('blog.urls')),

    url(r'^admin/', include(admin.site.urls)),
    url(r'^accounts/', include('users.urls')),
    url(r'^todo/', include('todo.urls')),
    url(r'^$', RedirectView.as_view(url='/accounts/login')),
)
