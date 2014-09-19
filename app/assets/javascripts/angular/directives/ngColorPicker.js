angular.module('ngColorPicker', [])
.directive('ngColorPicker', function() {
    var defaultColors =  [
        '#7bd148',
        '#5484ed',
        '#a4bdfc',
        '#46d6db',
        '#7ae7bf',
        '#51b749',
        '#fbd75b',
        '#ffb878',
        '#dc2127',
        '#e1e1e1',
    ];
    return {
        require: 'ngModel',
        scope: {
            customizedColors: '=colors',
            disabledColors: '=',
            selectedColor: '='
        },
        restrict: 'AE',
        template: '<ul ng-click="toggle()" ng-class="opened && \'color-picker-opened\'"><li ng-repeat="color in colors" ng-class="{selected: (color===selected)}" ng-click="pick(color)" style="background-color:{{color}};"><i class="ace-icon glyphicon glyphicon-ok"></i></li></ul><div class="clearfix"></div>',
        link: function (scope, element, attr, ngModel) {
            scope.opened = false;

            scope.colors = scope.customizedColors || defaultColors;
            scope.selected = attr.selected || scope.colors[0];
            scope.disabledColors = scope.disabledColors || []

            ngModel.$setViewValue(scope.selected);

            scope.pick = function (color) {
                if (scope.disabledColors.indexOf(color) != -1 || !scope.opened) {
                    return false;
                }

                scope.selected = color;
                ngModel.$setViewValue(color);
            }

            scope.toggle = function () {
                scope.opened = !scope.opened
            }
        }
    };

});