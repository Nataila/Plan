"use strict"

angular.module 'todoApp.services', []
  .factory('TodoService', ($http) ->
    return {
      send: (url, par) ->
        $http.get(url, params: par)

      get_default_data: ($scope, url, par) ->
        this.send(url, par).success((data) ->
          $scope.data = data
          return
        )
        return

      change_status: ($scope, url, par) ->
        this.send(url, par).success(->
          angular.forEach($scope.data, (item) ->
            if item.id is par.sid
              item.status = par.status
            return
          )
          return
        )
        return

      del: ($scope, url, par) ->
        this.send(url, par).success((data) ->
          angular.forEach($scope.data, (item) ->
            if item.id is par.sid
              index = $scope.data.indexOf(item)
              $scope.data.splice(index, 1)
            return
          )
          return
        )
        return

      save: ($scope, url, par) ->
        this.send(url, par).success((data) ->
          $scope.data.unshift
            id: data.id
            content: par.content
            status: false
            type: par.type
            time: data.time
          $scope.pushData = ''
          return
        )
        return
      drawPie: (chartData) ->
        chart:
          plotBackgroundColor: null
          plotBorderWidth: null
          plotShadow: false
        title:
          text: 'Plan完成情况'
        tooltip:
          pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
        plotOption:
          pie:
            allowPointSelect: true,
            cursor: 'pointer',
            dataLabels:
              enabled: true,
              color: '#000000',
              connectorColor: '#000000',
              format: '<b>{series.name}</b> {point.percentage:.1f} %'
        series: [
          type: 'pie'
          name: '我的plan'
          data: chartData
        ]
    }
  )

todoApp = angular.module 'todoApp', ['ui.router', 'todoApp.services']

todoApp.config(($httpProvider, $interpolateProvider) ->
  $interpolateProvider.startSymbol('[[').endSymbol(']]')
  $httpProvider.defaults.xsrfCookieName = 'csrftoken'
  $httpProvider.defaults.xsrfHeaderName = 'X-CSRFToken'
  return
)

todoApp.config ($stateProvider, $urlRouterProvider) ->
  $urlRouterProvider.otherwise '/plan'

  $stateProvider.state 'plan', {
    url: '/plan'
    templateUrl: 'plan.html'
    controller: 'HomeCtrl'
  }
  .state 'plan.day', {
    url: '/day'
    templateUrl: 'plan/detail'
    controller: 'DayCtrl'
  }
  .state 'plan.week', {
    url: '/week'
    templateUrl: 'plan/detail'
    controller: 'WeekCtrl'
  }
  .state 'plan.month', {
    url: '/month'
    templateUrl: 'plan/detail'
    controller: 'MonthCtrl'
  }
  return

todoApp.controller 'todoCtrl', ($scope, TodoService) ->
  $('.try').on 'click', ->
    $('.left.sidebar').sidebar({
      dimPage: false
      closable: false
   }).sidebar 'toggle'
    return

todoApp.controller 'HomeCtrl', ($scope) ->
  return

todoApp.directive 'sidebarSwitch', () ->
  link: (scope, elem, attrs) ->
    elem.bind 'click', () ->
      $('.sidebar').sidebar({
        dimPage: false
        transition: 'overlay'
      })
      .sidebar('toggle')
      return
    elem.bind 'mouseover', () ->
      elem.transition('pulse')

todoApp.controller 'DayCtrl', ($scope, $http, TodoService) ->
  $scope.statusChange = (sid, status)->
    TodoService.change_status($scope, 'change_status', {'sid': sid, 'status': status})
    return

  $scope.delete = (sid) ->
    TodoService.del($scope, 'delete', {'sid': sid})

  $scope.send = () ->
    sendData = {
      'content' : $scope.pushData
      'type': 'day'
    }
    TodoService.save($scope, 'save', sendData)
    return
  return

todoApp.controller 'WeekCtrl', ($scope, $http, TodoService) ->
  TodoService.get_default_data($scope, 'get_default_data', {'type': 'week'})
  $scope.statusChange = (sid, status)->
    TodoService.change_status($scope, 'change_status', {'sid': sid, 'status': status})
    return

  $scope.delete = (sid) ->
    TodoService.del($scope, 'delete', {'sid': sid}, 'day')

  $scope.send = () ->
    sendData = {
      'content' : $scope.pushData
      'type': 'week'
    }
    TodoService.save($scope, 'save', sendData)
    return
  return

todoApp.controller 'MonthCtrl', ($scope, $http, TodoService) ->
  TodoService.get_default_data($scope, 'get_default_data', {'type': 'month'})
  $scope.statusChange = (sid, status)->
    TodoService.change_status($scope, 'change_status', {'sid': sid, 'status': status})
    return

  $scope.delete = (sid) ->
    TodoService.del($scope, 'delete', {'sid': sid})

  $scope.send = () ->
    sendData = {
      'content' : $scope.pushData
      'type': 'month'
    }
    TodoService.save($scope, 'save', sendData)
  return

todoApp.directive 'planProgress', ($http, $location)->
  scope: false
  link: (scope, elem, attrs) ->
    get_type = $location.path().split('/')[2]
    scope.path = get_type
    $http.get('get_default_data', params: {'type': get_type}).then (data) ->
      scope.percentCount = (data) ->
        truecount = percent = 0
        angular.forEach data, (item) ->
          if item.status
            truecount += 1
          return
        percent = (truecount/data.length).toFixed(3)*100
      scope.data = data.data
      scope.done = scope.percentCount(scope.data)
      scope.$watch('data', () ->
        elem.progress(
          percent: scope.percentCount(scope.data)
        )
        return
      true
      )
      return
    return

todoApp.directive 'drawPie', ($http, TodoService) ->
  scope: false
  link: (scope, elem, attrs) ->
    TodoService.send('drawpie').then((data) ->
      elem.highcharts(TodoService.drawPie(data.data))
    )
    return

todoApp.directive 'dropDown', () ->
  link: (scope, elem, attrs) ->
    elem.dropdown(
      on: 'hover'
    )

todoApp.directive 'setFocus', () ->
  link: (scope, elem, attrs) ->
    elem.transition('tada')
    elem.focus()

