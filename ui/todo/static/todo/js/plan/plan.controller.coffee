"use strict"

angular.module 'todoApp'
  .controller 'todoCtrl', ($scope, TodoService) ->
    $('.try').on 'click', ->
      $('.left.sidebar').sidebar({
        dimPage: false
        closable: false
     }).sidebar 'toggle'
      return

  .controller 'HomeCtrl', ($scope) ->
    return

  .controller 'DayCtrl', ($scope, $http, $location, TodoService) ->
    $scope.addr = TodoService.getAddr()
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

  .controller 'WeekCtrl', ($scope, $http, $location, TodoService) ->
    $scope.addr = TodoService.getAddr()
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

  .controller 'MonthCtrl', ($scope, $http, $location, TodoService) ->
    $scope.addr = TodoService.getAddr()
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
