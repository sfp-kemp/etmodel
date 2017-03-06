/* globals Gquery Metric */

(function () {
  // Helper Functions ----------------------------------------------------------

  /**
   * Given a the value a component's `content` attribute, splits the string into
   * an array of objects describing the individual parts.
   *
   * These are of the form:
   *   { type: 'literal', content: 'Some content' },
   *   { type: 'query', period: 'future', key: 'queryId' }

   * @param  {string} template The component content string.
   * @return {array}
   */
  var templateParts = function templateParts(template) {
    // Splits the template by all uses of a query.
    var splitRe = /\b((?:future|present)\([^)]+\))/g;

    // Splits an individual query into its parts.
    var indivRe = /^((future|present)\(([^)]+)\))$/;

    if (!template || !template.length) {
      return [];
    }

    return template.split(splitRe).map(function (token) {
      var splitQuery = token.match(indivRe);

      if (!splitQuery) {
        return { type: 'literal', content: token };
      }

      return { type: 'query', period: splitQuery[2], key: splitQuery[3] };
    });
  };

  // Component Views -----------------------------------------------------------

  var QueryValue = Backbone.View.extend({
    tagName: 'span',
    className: 'query-value',

    initialize: function (options) {
      this.query = options.query;
      this.value = this.query[options.period + '_value'];

      this.listenTo(this.query, 'change:' + options.period, this.render);
    },

    render: function () {
      var value = this.value.call(this.query);

      if (value !== undefined) {
        this.$el.html(Metric.autoscale_value(
          this.query.safe_future_value(),
          this.query.get('unit')
        ));

        // We have a value, no need to continue listening.
        this.stopListening();
        this.query.release();
      } else {
        this.$el.text('???');
      }

      return this.$el;
    }
  });

  /**
   * Given part of a parsed component content, creates the appropriate
   * representation to be rendered to the visitor.
   */
  var renderTemplatePart = function renderTemplatePart(part) {
    switch (part.type) {
      case 'literal':
        return part.content;
      case 'query':
        return new QueryValue({
          query: window.gqueries.find_or_create_by_key(part.key),
          period: part.period
        }).render();
      default:
        throw new Error('Unknown part type: ' + part.type);
    }
  };

  /**
   * A generic report component view.
   *
   * Extend as necessary and add a branch to ReportComponentView.forModel to
   * create a different view for certain components. Descendants may implement
   * a custom childView to further customise how child components are rendered.
   */
  var ReportComponentView = Backbone.View.extend({
    tagName: 'div',
    className: 'report-component',

    render: function () {
      var self = this;

      templateParts(this.model.get('content')).forEach(function (part) {
        self.$el.append(renderTemplatePart(part));
      });

      if (this.tagName === 'span') {
        // Separate inline <span/> components with a space.
        this.$el.append(' ');
      }

      this.$el.append(
        this.model.get('children').map(function (child) {
          return self.childView(child).render();
        })
      );

      return this.$el;
    },

    /**
     * Given a child model, creates the view needed to preset the contents to
     * the visitor.
     *
     * This method allows subclasses to define custom views for child
     * components.
     */
    childView(child) {
      return ReportComponentView.forModel(child);
    }
  });

  /**
   * A component view which forces all child components to be rendered as inline
   * <span/> elements. Useful when the component is an which may only contain
   * phrasing elements and plain text (e.g. h1, h2, p, etc).
   */
  var InlineChildrenView = ReportComponentView.extend({
    childView: function (model) {
      return new ReportComponentView({ model: model, tagName: 'span' });
    }
  });

  /**
   * Report component view which represents "block-level" text such as headers
   * and paragraphs.
   */
  var TextReportComponentView = InlineChildrenView.extend({
    className: 'report-component text',

    tagName: function () {
      if (this.isHeader()) {
        // Headers
        return this.model.get('type');
      }

      return 'p';
    },

    isHeader: function () {
      return this.model.get('type').match(/^h[1-6]$/i);
    }
  });

  /**
   * A report component view which renders a chart. See ReportView.renderInfo
   * for caveats involving chart rendering.
   */
  var ChartReportComponentView = InlineChildrenView.extend({
    tagName: 'div',
    className: 'report-component chart',

    /**
     * Chart components render the chart as an empty <div> (to be later picked
     * up and rendered as a real chart), and child components are presented as
     * a caption.
     */
    render: function () {
      var children;
      var caption;
      var i;

      this.$el.append(
        $('<div class="chart_inner" />')
          .attr('id', _.uniqueId('rchart_'))
          .data('report-chart-id', this.model.get('content'))
      );

      if (this.model.get('children').length) {
        // Append child components as a caption.
        caption = $('<div class="caption" />');
        children = this.model.get('children');

        for (i = 0; i < children.length; i += 1) {
          caption.append(this.childView(children[i]).render());
        }

        this.$el.append(caption);
      }

      return this.$el;
    }
  });

  /**
   * Given a component model, initializes a suitable view.
   *
   * @param  {ReportComponent} model The model instance.
   * @param  {string} forceType Overrides the model type with a custom type.
   *
   * @return {[type]} Returns the initialized view.
   */
  ReportComponentView.forModel = function (model, forceType) {
    switch (forceType || model.get('type')) {
      case 'text':
      case 'h1':
      case 'h2':
      case 'h3':
      case 'h4':
      case 'h5':
      case 'h6':
        return new TextReportComponentView({ model: model });
      case 'chart':
        return new ChartReportComponentView({ model: model });
      default:
        return new ReportComponentView({ model: model });
    }
  };

  window.ReportComponentView = ReportComponentView;
}());
