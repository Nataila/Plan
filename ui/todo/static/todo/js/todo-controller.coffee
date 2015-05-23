"use strict"

angular.module 'todoApp.services', []
  .factory('TodoService', ($http) ->
    return {
      send: (url, par) ->
        $http.get(url, params: par)

      get_default_data: ($scope, url, par) ->
        this.send(url, par).success((data) ->
          $scope.day = data
          return
        )
        return

      change_status: ($scope, url, par) ->
        this.send(url, par).success(->
          angular.forEach($scope.day, (item) ->
            if item.id is par.sid
              item.status = par.status
            console.log $scope.day
            return
        )
      )
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
    templateUrl: 'plan/day'
    controller: 'DayCtrl'
  }
  .state 'plan.week', {
    url: '/week'
    templateUrl: 'plan/week'
  }
  .state 'plan.month', {
    url: '/month'
    templateUrl: 'plan/month'
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
    TodoService.send('delete', {'sid': sid}).success((data) ->
      angular.forEach($scope.day, (item) ->
        if item.id is sid
          item['ishide'] = true
        return
      )
    )
  $scope.send = () ->
    sendData = {
      'content' : $scope.pushData,
      'type': 'day'
    }
    TodoService.send('save', sendData).success( (data)->
      $scope.day.unshift({
        id: data.id
        content: $scope.pushData
        status: false
        type: 'day'
        time: data.time
      })
      $scope.pushData = ''
      return
    )
  return

