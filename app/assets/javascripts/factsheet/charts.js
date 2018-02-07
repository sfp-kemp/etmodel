/* globals Quantity Metric d3 */

(function() {
  var definitions = {
    demand: [
      { key: 'final_demand_of_electricity', color: '#fbca36' },
      { key: 'factsheet_demand_of_collective_heat', color: '#eb3138' },
      {
        key: 'factsheet_demand_of_gas_in_industry_agriculture_other',
        color: '#3b73bf'
      },
      {
        key: 'factsheet_demand_of_gas_in_households_and_buildings',
        color: '#56aee4'
      },
      { key: 'factsheet_demand_of_gasoline_diesel_lpg', color: '#82ca39' }
    ],
    futureDemand: [
      { key: 'factsheet_demand_of_electricity_future', color: '#fbca36' },
      { key: 'factsheet_demand_of_heat_total', color: '#eb3138' },
      {
        key: 'factsheet_demand_of_gas_total',
        color: '#56aee4'
      },
      { key: 'factsheet_demand_of_biomass_transport', color: '#82ca39' }
    ],
    breakdown: [
      { key: 'electricity_produced_from_wind', color: '#f4a540' },
      { key: 'electricity_produced_from_solar', color: '#fbca36' },
      { key: 'factsheet_demand_of_collective_heat', color: '#a41824' },
      {
        key: 'factsheet_demand_of_individual_heat_all_electric',
        color: '#bc1a27'
      },
      {
        key: 'factsheet_demand_of_biomass_in_households_and_buildings',
        color: '#e73133'
      },
      {
        key: 'factsheet_demand_of_water_heater_solar_thermal',
        color: '#eb5a3c'
      },
      {
        key: 'final_demand_of_hydrogen_in_transport',
        color: '#2c3480'
      },
      {
        key: 'factsheet_demand_of_greengas',
        color: '#2874b4'
      },
      {
        key: 'factsheet_demand_of_natural_gas',
        color: '#56aee4'
      },
      { key: 'factsheet_demand_of_biomass_transport', color: '#82ca39' }
    ]
  };

  function totalValue(gqueries, series, period) {
    return d3.sum(series, function(serie) {
      return gqueries[serie.key][period];
    });
  }

  function valueScaler(gqueries, series, period) {
    var unit = gqueries[series[0].key].unit;

    var max = d3.max(series, function(serie) {
      return gqueries[serie.key][period];
    });

    if (Quantity.isSupported(unit)) {
      return Quantity.scaleAndFormatBy(max, unit, {});
    }

    return function(value) {
      return Metric.autoscale_value(value, unit, 2, false);
    };
  }

  function chartSeriesFromRequest(gqueries, series, period) {
    // Create a unit scaler.
    return series.map(function(serie) {
      return $.extend({}, serie, {
        value: gqueries[serie.key][period]
      });
    });
  }

  /**
   * Generic version of presentDemandChart and futureDemandChart.
   */
  function demandChart(gqueries, period, definition) {
    var scale = function(value, unit) {
      return new Quantity(value, 'MJ').to('TJ').format();
    };

    return {
      title: 'Energievraag',
      formatValue: scale,
      series: chartSeriesFromRequest(gqueries, definition, period),
      margin: {
        top: 10,
        right: 0,
        bottom: 25,
        left: 75
      }
    };
  }

  /**
   * Renders a chart describing the present demand of the scenario.
   */
  function presentDemandChart(gqueries) {
    return demandChart(gqueries, 'present', definitions.demand);
  }

  /**
   * Renders a chart describing the future demand of the scenario.
   */
  function futureDemandChart(gqueries) {
    return demandChart(gqueries, 'future', definitions.futureDemand);
  }

  /**
   * Renders a chart describing individual demands for the future.
   */
  function futureDemandBreakdownChart(gqueries) {
    var max = totalValue(gqueries, definitions.futureDemand, 'future');

    return {
      title: 'Energieaanbod',
      formatValue: function() {
        return '';
      },
      max: max,
      margin: { top: 10, right: 0, bottom: 25, left: 5 },
      series: chartSeriesFromRequest(gqueries, definitions.breakdown, 'future')
    };
  }

  window.charts = {
    presentDemandChart: presentDemandChart,
    futureDemandChart: futureDemandChart,
    futureDemandBreakdownChart: futureDemandBreakdownChart,
    definitions: definitions
  };
})();
