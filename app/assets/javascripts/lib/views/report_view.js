/* globals ReportComponentView ReportComponent */
(function () {
  /**
   * Takes an array of report component data and recursively renders the
   * components.
   *
   * For example
   *   new ReportView({ components: [{ ... }] });
   */
  var ReportView = Backbone.View.extend({
    className: 'report-view',

    /**
     * Renders the report into the given element, running post-processing
     * methods as necessary to fetch charts and other scenario data. Prefer this
     * over using render() and renderCharts().
     */
    renderInto: function (container) {
      container.append(this.render());
      this.renderCharts();
    },

    render: function () {
      var components = this.options.components;
      var i;

      for (i = 0; i < components.length; i += 1) {
        this.$el.append(
          ReportComponentView.forModel(
            ReportComponent.buildComponent(components[i])
          ).render()
        );
      }

      return this.$el;
    },

    /**
     * Post-processing method which looks through the rendered report for a list
     * of charts to be rendered.
     */
    renderCharts: function () {
      var requests = {};

      $(this.$el.find('.chart_inner')).each(function (index, el) {
        var chartEl = $(el);
        var holderId = _.uniqueId('rchart_holder_');
        var chartId = chartEl.data('report-chart-id');

        window.charts.add_container_if_needed(holderId, {
          wrapper: '#' + chartEl.attr('id'),
          header: false
        });

        requests[holderId] = chartId + '-C';
      });

      window.charts.load_charts(requests);
    }
  });

  window.ReportView = ReportView;
}());
