registerApp = angular.module('registerApp', ['ngRoute'])
registerApp.config(($httpProvider, $interpolateProvider) ->
  $interpolateProvider.startSymbol('[[').endSymbol(']]')
  $httpProvider.defaults.xsrfCookieName = 'csrftoken'
  $httpProvider.defaults.xsrfHeaderName = 'X-CSRFToken'
  return
)
registerApp.config(['$routeProvider', ($routeProvider)->
  $routeProvider.when '/ss',
    template: "<div>hello</div>"
    controller: "LoginCtr"
  return
])
registerApp.controller('registerCtrl',  ($scope, $http) ->
  $scope.checkPasswd = ->
    $scope.repeat = true
    return

  $scope.submitRegisterForm = ->
    if $scope.registerForm.$valid
      promise = $http(
        method: 'POST'
        url: '.'
        data: $scope.user
      )
      promise.success((data, status, headers, ocnfig) ->
        if data.status is 200
          console.log 'ok'
        return
      )
    else
      console.log 3333
    return
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

