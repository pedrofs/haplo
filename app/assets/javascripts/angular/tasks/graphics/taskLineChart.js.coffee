angular.module('tccless').value 'taskLineChart',
      height: 187
      axesDefaults:
        min: 0, 
        tickInterval: 1
        tickOptions:
          formatString: '%d' 
      axes: 
        xaxis:
          pad: 0
          renderer:$.jqplot.DateAxisRenderer
      series:[{label: 'Abertas', lineWidth:2, markerOptions:{style:'square'}}, {label: 'Fechadas', lineWidth:2, markerOptions:{style:'square'}}]
      legend:
        show: true
        location: 'e'