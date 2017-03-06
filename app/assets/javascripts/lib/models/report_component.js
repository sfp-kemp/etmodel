(function () {
  'use strict';

  var ReportComponent = Backbone.Model.extend({
    /**
     * Scans the component contents for values which require Gquery results.
     */
    requirements: function () {
      var matches;

      if (!this.get('content')) {
        return [];
      }

      matches = this.get('content').match(/(future|present)\(([^)]+)\)/g);

      if (!matches) {
        return [];
      }

      return matches.map(function (match) {
        return match.match(/(future|present)\(([^)]+)\)/)[2];
      });
    }
  });

  /**
   * Given data about a report component, builds the ReportComponent model and
   * recursively converts any children to components.
   *
   * @param  {object} data The component data.
   * @return {ReportComponent}
   */
  ReportComponent.buildComponent = function (data) {
    var children = [];
    var i;

    if (data.children && data.children.length) {
      for (i = 0; i < data.children.length; i += 1) {
        children.push(ReportComponent.buildComponent(data.children[i]));
      }
    }

    return new ReportComponent(_.extend({}, data, { children: children }));
  };

  window.ReportComponent = ReportComponent;
}());
