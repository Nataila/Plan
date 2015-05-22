"use strict"
todoApp = angular.module 'todoApp', ['ui.router']

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

todoApp.controller 'todoCtrl', ($scope) ->
  $('.try').on 'click', ->
    $('.left.sidebar').sidebar({
      dimPage: false
      closable: false
   }).sidebar 'toggle'
    return

todoApp.controller 'DayCtrl', ($scope, $http) ->
  $http.get('get_default_data', params: {'type': 'day'}).success((data) ->
    $scope.day = data
  )
  $scope.statusChange = (sid, status)->
    $http.get('change_status', params: {'sid': sid, 'status': status}).success(->
      angular.forEach($scope.day, (item) ->
        if item.id is sid
          item.status = status
        return
      )
    )
  $scope.delete = (event, sid) ->
    $http.get('delete', params: {'sid': sid}).success((data) ->
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
    $http.post('save', sendData).success( (data)->
      $scope.day.push({
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

