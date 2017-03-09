/* globals ReportComponentView ReportComponent globals */
(function () {
  /**
   * Determines if ETE errors should be shown to the visitor instead of a simple
   * message.
   */
  var showFullErrors = function showFullErrors() {
    return (
      globals.env === 'development' ||
      globals.env === 'test' ||
      globals.debug_js
    );
  };

  /**
   * Formats individual ETE error messages.
   */
  var formatError = function formatError(message) {
    var split = message.split(' | ');
    var messageEl = $('<li />')
      .append($('<h3 class="summary" />').text(split[0]));

    if (split.length > 1) {
      messageEl.append($('<pre />').html(split[1]));
    }

    return messageEl;
  };

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

      if (this.options.errors) {
        return this.renderErrors(this.options.errors);
      }

      for (i = 0; i < components.length; i += 1) {
        this.$el.append(
          ReportComponentView.forModel(
            ReportComponent.buildComponent(components[i])
          ).render()
        );
      }

      return this.$el;
    },

    renderErrors: function (messages) {
      var errors = $('<div class="report-errors"></div>');

      errors.append($('<p />').text(
        'Sorry, your report could not be created.'
      ));

      if (showFullErrors()) {
        errors.append($('<ul />').append(messages.map(formatError)));
      }

      this.$el.empty().append(errors);

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
