angular.module 'todoApp'
  .config ($httpProvider, $interpolateProvider, $stateProvider, $urlRouterProvider) ->
    $interpolateProvider.startSymbol('[[').endSymbol(']]')
    $httpProvider.defaults.xsrfCookieName = 'csrftoken'
    $httpProvider.defaults.xsrfHeaderName = 'X-CSRFToken'
  
    $urlRouterProvider.otherwise '/plan'
    $stateProvider.state 'plan', {
      url: '/plan'
      templateUrl: 'plan.html'
      controller: 'HomeCtrl'
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
    return
