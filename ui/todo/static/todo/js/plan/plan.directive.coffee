angular.module 'todoApp'
  .directive 'planProgress', ($http, $location)->
    scope: false
    link: (scope, elem, attrs) ->
      get_type = $location.path().split('/')[2]
      scope.path = get_type
      $http.get('get_default_data', params: {'type': get_type}).then (data) ->
        scope.percentCount = (data) ->
          truecount = percent = 0
          angular.forEach data, (item) ->
            if item.status
              truecount += 1
            return
          percent = (truecount/data.length).toFixed(3)*100
        scope.data = data.data
        scope.done = scope.percentCount(scope.data)
        scope.$watch('data', () ->
          elem.progress(
            percent: scope.percentCount(scope.data)
          )
          return
        true
        )
        return
      return

  .directive 'drawPie', ($http, TodoService) ->
    scope: false
    link: (scope, elem, attrs) ->
      TodoService.send('drawpie').then((data) ->
        elem.highcharts(TodoService.drawPie(data.data))
      )
      return

  .directive 'dropDown', () ->
    link: (scope, elem, attrs) ->
      elem.dropdown(
        on: 'hover'
      )

  .directive 'addAnimate', () ->
    link: (scope, elem, attrs) ->
      elem.transition(
        animation: 'bounce'
        duration: '1500ms'
      )

  .directive 'setFocus', () ->
    link: (scope, elem, attrs) ->
      elem.focus()

  .directive 'listDirective', () ->
    link: (scope, elem, attrs) ->
      elem.transition(
        animation: 'drop'
        duration: '1500ms'
      )

  .directive 'sidebarSwitch', () ->
    link: (scope, elem, attrs) ->
      elem.bind 'click', () ->
        $('.sidebar').sidebar({
          dimPage: false
          transition: 'overlay'
        })
        .sidebar('toggle')
        return
      elem.bind 'mouseover', () ->
        elem.transition('pulse')
  .directive 'detailDirective', () ->
    link: (scope, elem, attrs) ->
      elem.bind 'hover', () ->
        console.log 3333123
        return
