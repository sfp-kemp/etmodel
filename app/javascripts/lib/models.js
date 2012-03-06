/*
 * convention for model files:
 * a file models/foo.js should contain:
 * - var Foo = Backbone.Model.extend({})
 * - var FooList = Backbone.Collection.extend({})
 * - optionally: window.foos = new FooList()
 * 
 * This imitates the Rails way, where Model and Collection
 * is in the same class/file. And reduces file-count.
 *
 */


//= require <lib/models/constraint.js>
//= require <lib/models/chart.js>
//= require <lib/models/chart_serie.js>
//= require <lib/models/block_chart_serie.js>
//= require <lib/models/scatter_chart_serie.js>
//= require <lib/models/input_element.js>
//= require <lib/models/input_element_balancer.js>
//= require <lib/models/metric.js>
//= require <lib/models/gquery.js>
//= require <lib/models/peak_load.js>
//= require <lib/models/scenario.js>
//= require <lib/models/policy_goal.js>
//= require <lib/models/setting.js>
//= require <lib/models/tracker.js>
