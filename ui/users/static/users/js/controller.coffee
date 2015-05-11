registerApp = angular.module('registerApp', [])
registerApp.controller('registerCtrl',  ($scope) ->
  $scope.submitForm = (isValid) ->
    if isValid ?
      123
    else
      555
)
