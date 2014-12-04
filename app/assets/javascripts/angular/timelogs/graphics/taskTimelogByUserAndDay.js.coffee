angular.module('tccless').value 'taskTimelogByUserAndDay',
      xaxis:
        mode: "time"
        timeformat: "%d/%m"
      series:
        stack: false
        lines:
          show: true
          fill: true
          steps: true
        bars:
          show: true
          