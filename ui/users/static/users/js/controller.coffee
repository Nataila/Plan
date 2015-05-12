registerApp = angular.module('registerApp', []).config(($httpProvider) ->
  $httpProvider.defaults.xsrfCookieName = 'csrftoken'
  $httpProvider.defaults.xsrfHeaderName = 'X-CSRFToken'
  return
)
registerApp.controller('registerCtrl',  ($scope, $http) ->
  $scope.submitRegisterForm = ->
    if $scope.registerForm.$valid
      console.log $scope.user
      $http({
        method: 'POST'
        url: '.'
        data: $scope.user
      })
    else
      console.log 3333
)

registerApp.directive('passwordVerify', ->
  return {
    require: 'ngModel'
    link: (scope, elem, attrs, ctrl) ->
      ctrl.$parsers.unshift((viewValue, $scope) ->
        noMath = viewValue is scope.registerForm.password1.$viewValue
        ctrl.$setValidity('noMath', noMath)
        return viewValue
      )
  }
)
