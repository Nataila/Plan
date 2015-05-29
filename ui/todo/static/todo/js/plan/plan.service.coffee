angular.module 'todoApp'
  .factory('TodoService', ($http, $location) ->
    send: (url, par) ->
      $http.get(url, params: par)

    get_default_data: ($scope, url, par) ->
      this.send(url, par).success((data) ->
        $scope.data = data
        return
      )
      return

    change_status: ($scope, url, par) ->
      this.send(url, par).success(->
        angular.forEach($scope.data, (item) ->
          if item.id is par.sid
            item.status = par.status
          return
        )
        return
      )
      return

    del: ($scope, url, par) ->
      this.send(url, par).success((data) ->
        angular.forEach($scope.data, (item) ->
          if item.id is par.sid
            index = $scope.data.indexOf(item)
            $scope.data.splice(index, 1)
          return
        )
        return
      )
      return

    getAddr: () ->
      pathDict =
        '/plan/day': '日计划'
        '/plan/week': '周计划'
        '/plan/month': '月计划'
      path = $location.path()
      return pathDict[path]

    save: ($scope, url, par) ->
      this.send(url, par).success((data) ->
        $scope.data.unshift
          id: data.id
          content: par.content
          status: false
          type: par.type
          time: data.time
        $scope.pushData = ''
        return
      )
      return
    drawPie: (chartData) ->
      chart:
        plotBackgroundColor: null
        plotBorderWidth: null
        plotShadow: false
      title:
        text: 'Plan完成情况'
      tooltip:
        pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
      plotOption:
        pie:
          allowPointSelect: true,
          cursor: 'pointer',
          dataLabels:
            enabled: true,
            color: '#000000',
            connectorColor: '#000000',
            format: '<b>{series.name}</b> {point.percentage:.1f} %'
      series: [
        type: 'pie'
        name: '我的plan'
        data: chartData
      ]
  )


