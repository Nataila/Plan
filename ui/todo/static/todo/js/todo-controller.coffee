todoApp = angular.module 'todoApp', ['ngRoute']

todoApp.controller 'todoCtrl', ($scope) ->
  console.log 123

todoApp.config '$routeProvider', ($routeProvider) -> 
  $routeprovider
    .when 'todo/day', {
    template: '<div class="box" ng-class="classname">Edit</div>',
    controller: ($scope) ->
      $scope.classname="edit"
      return
  }
    .otherwise
      redirecTo: 'todo'
  return
