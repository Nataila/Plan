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
  $scope.day = [1,2,3]
  $scope.send = () ->
    sendData = {
      'content' : $scope.pushData,
      'type': 'day'
    }
    $http.post('save', sendData).success(->
      $scope.day.push({
        content: $scope.pushData
        status: 0
        type: 'day'
        time: '1900-01-01 07:43:20'
      })
      $scope.pushData = ''
      return
    )
  return

todoApp.directive('todoCheckbox', ->
  return {
    terminal: true
    restrict: 'A'
    link: (scope, elem, attrs) ->
      elem.checkbox()
      return
  }
)
