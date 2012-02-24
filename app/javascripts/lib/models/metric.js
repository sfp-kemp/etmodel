var Metric = {
  /* previous stuff, to be refactored. Charts still make use of this */
  
  parsed_unit : function(value, unit) {
    var start_scale; 

    if (unit == "MT") {
      start_scale = 2;
    } else if (unit == "euro") {
      // quick ugly fix
      unit == "EUR";
      start_scale = 0; 
    } else {
      start_scale = 3;
    }

    var scale = Metric.scaled_scale(value, start_scale);

    if (unit == 'PJ') {
      if (scale >= 3 && scale < 5) scale = 3;
      return Metric.scaling_in_words(scale, 'joules');
    } else if (unit == 'MT') {
      return Metric.scaling_in_words(scale, 'ton');
    } else if (unit == 'EUR') {
      return Metric.scaling_in_words(scale, 'currency');
    } else if (unit == 'MW') {
      return Metric.scaling_in_words(scale, 'watt');
    } else if (unit == '%') {
      return '%';
    } else {
      return Metric.scaling_in_words(scale, unit);
    }
  },

  scaled : function(value, start_scale, target_scale, max_scale) {
    var scale = start_scale || 0;
    var target = target_scale || null;
    var min_scale = 0;
    max_scale = max_scale || 100;
    
    if (!target) {
      while (value >= 0 && scale < max_scale) {
        value = value / 1000;
        scale = scale + 1;
      }
      while (value < 1 && scale > min_scale) {
        value = value * 1000;
        scale = scale - 1;
      }
    } else {
      var diff = target - scale;
      for (var i = Math.abs(diff); i > 0; i -= 1) {
        if (diff < 0) {
          value = value * 1000;
          scale = scale - 1;
        } else {
          value = value / 1000;
          scale = scale + 1;
        }
      }
    }
    return [parseInt(scale), value];
  },

  scaled_scale : function(value, start_scale, target_scale, max_scale) {
    return this.scaled(value, start_scale, target_scale, max_scale)[0];
  },
  
  scaled_value : function(value, start_scale, target_scale, max_scale) {
    return this.scaled(value, start_scale, target_scale, max_scale)[1];
  },

  // Doesn't add trailing zeros. Let's use sprintf.js in case
  round_number : function(value, precision) {
    var rounded = Math.pow(10, precision);
    return Math.round(value * (rounded)) / rounded;
  },

  calculate_performance : function(now, fut) {
    if (now != null || fut != null) {
      var performance = (fut / now) - 1;
      return performance;
    } else {
    return null;
    }
  },

  /*
   * Translates a scale to a words:
   * 1000 ^ 1 = thousands
   * 1000 ^ 2 = millions
   * etc.
   *
   * @param scale [Float] The scale that must be translated into a word
   * @param unit [String] The unit - currently {currency|joules|nounit|ton}
   * Add other units on config/locales/{en|nl}.yml
   */
  scaling_in_words : function(scale, unit) {
    var scale_symbols = {
      "0" : 'unit',
      "1" : 'thousands',
      "2" : 'millions',
      "3" : 'billions',
      "4" : 'trillions',
      "5" : 'quadrillions',
      "6" : 'quintillions'
    };
    var symbol = scale_symbols["" + scale];

    return I18n.t("units." + unit + "." + symbol);
  },
  
  /* new stuff */
  
  // given a value and a unit, returns a translated string
  // uses i18n.js, so be sure the required translation keys
  // are available.
  // The available units are:
  //
  // av(20, '%') => 20%
  // av(1234)    => 1234
  autoscale_value : function(x, unit, precision) {
    precision  = precision || 0;
    var pow    = Metric.power_of_thousand(x);
    var value  = x / Math.pow(1000, pow);
    value = Metric.round_number(value, precision);
    var scale_string = Metric.power_of_thousand_to_string(pow);

    var prefix = '';
    var out    = '';
    var suffix = '';

    switch(unit) {
      case '%' :
        out = Metric.percentage_to_string(x);
        break;
      case 'MJ' :
        out = x / Math.pow(1000, pow);
        suffix = I18n.t('units.joules.' + scale_string);
        break;
      case 'MW' :
        out = x / Math.pow(1000, pow);
        suffix = I18n.t('units.watt.' + scale_string);
        break;
      case 'euro':
        out = value;
        prefix = "&euro;";
        break;
      default :
        out = x;
    }

    output = prefix + out + suffix;
    return output;
  },

  /* formatters */

  // x: the value - no transformations on it
  // prefix: if true, add a leading + on positive values
  // precision: default = 1, the number of decimal points
  // pts(10) => 10%
  // pts(10, true) => +10%
  // pts(10, true, 2) => 10.00%
  percentage_to_string: function(x, prefix, precision) {
    precision = precision || 1;
    prefix = prefix || false;
    value = Metric.round_number(x, precision);
    if (prefix && (value > 0.0)) { value = "+" + value; }
    return '' + value + '%';
  },

  // as format_percentage, but multiplying the value * 100
  ratio_as_percentage: function(x, prefix, precision) {
    return Metric.percentage_to_string(x * 100, prefix, precision);
  },

  /* This formatter is used by the total_costs dashboard item. Since its behaviour is
     very specific I'm keeping it separated from autoscale_value.
     1_000_000     => &euro;1mln
     -1_000_000    => -&euro;1mln
     1_000_000_000 => &euro;1bln
     The unit_suffix parameters adds a translated mln/bln suffix
  */
  euros_to_string: function(x, unit_suffix) {
    var prefix    = x < 0 ? '-' : '';
    var abs_value = Math.abs(x);
    var scale     = Metric.power_of_thousand(x);
    var value     = abs_value / Math.pow(1000, scale);
    var suffix    = '';
    var rounded;

    if (unit_suffix) {
     suffix = I18n.t('units.currency.' + Metric.power_of_thousand_to_string(scale));
    }

    rounded = Metric.round_number(value, 1).toString();

    // If the number is < 1000, and has decimal places, make sure that the
    // number isn't truncated to something like 5.4, but instead returns 5.40.
    if (abs_value < 1000 && _.indexOf(rounded, '.') !== -1) {
      rounded = rounded.split('.');

      if (rounded[1] && rounded[1].length === 1) {
        rounded[1] += '0';
      }

      rounded = rounded.join('.');
    }

    return prefix + '&euro;' + rounded + suffix;
  },


  /* utility methods */

  // 0-999: 0, 1000-999999: 1, ...
  power_of_thousand: function(x) {
    return parseInt(Math.log(Math.abs(x)) / Math.log(1000));
  },

  // Returns the string currently used on the i18n file
  power_of_thousand_to_string: function(x) {
    switch(x) {
      case 0:
        return 'unit';
      case 1:
        return 'thousands';
      case 2:
        return 'millions';
      case 3:
        return 'billions';
      case 4:
        return 'trillions';
      case 5:
        return 'quadrillions';
      case 6:
        return 'quintillions';
      default:
        return null;
    }
  }
}
