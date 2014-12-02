angular.module('tccless').value 'taskPieChart',
      height: 200
      seriesDefaults:
        renderer: jQuery.jqplot.DonutRenderer
        rendererOptions:
          showDataLabels: true
          dataLabels: 'value'
      legend:
        show: true
        location: 'e'