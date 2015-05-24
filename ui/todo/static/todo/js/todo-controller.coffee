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
              item['ishide'] = true
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
          return
        )
        return
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
  .state 'report', {
    url: '/report'
    templateUrl: 'report.html'
  }
  return

todoApp.controller 'todoCtrl', ($scope, TodoService) ->
  $('.try').on 'click', ->
    $('.left.sidebar').sidebar({
      dimPage: false
      closable: false
   }).sidebar 'toggle'
    return

todoApp.controller 'DayCtrl', ($scope, $http, TodoService) ->
  TodoService.get_default_data($scope, 'get_default_data', {'type': 'day'})
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
  return

todoApp.directive 'planProgress', ()->
  scope: false
  link: (scope, elem, attrs) ->
    attrs.$set('value', 10)
    attrs.$set('total', 20)
    elem.progress(
    )
    return
