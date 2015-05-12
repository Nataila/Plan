registerApp = angular.module('registerApp', [])
registerApp.controller('registerCtrl',  ($scope) ->
  $scope.submitRegisterForm = ->
    if $scope.registerForm.$valid
      console.log 3333
    else
      console.log 555
)

registerApp.directive('passwordVerify', ->
  return {
    require: 'ngModel'
    link: (scope, elem, attrs, ctrl) ->
      ctrl.$parsers.unshift((viewValue, $scope) ->
        noMath = viewValue is scope.registerForm.password1.$viewValue
        ctrl.$setValidity('noMath', noMath)
      )
  }
)
