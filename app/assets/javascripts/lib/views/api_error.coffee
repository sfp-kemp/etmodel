splitAtFirst = (string, split) ->
  index = string.indexOf(split)

  if index == -1
    [string]
  else
    [string.slice(0, index + 1), string.slice(index)]

class @ApiErrorView extends Backbone.View
  id: 'api-error'

  events:
    'click .refresh': (event) ->
      event.preventDefault()
      window.location = window.location

  render: ->
    @$el.append($('<h1>').append(
      $('<span class="fa fa-exclamation-triangle"/>'),
      ' ETEngine returned an error'
    ))

    @$el.append($('<div class="buttons"/>').append(
      $('<a href="/" class="primary">&larr; Back to the home page</a>'),
      $('<a class="refresh">Refresh and try again</a>').attr(
        'href', location.pathname
      ),
      $('<a class="open-api">View scenario in ETEngine</a>').attr(
        'href', @options.scenarioURL
      )
    ))

    if 400<= @options.status < 500 && @options.responseJSON
      @$el.append(@renderJSONErrors())
    else
      @$el.append($('<pre class="server-error" />').text(@options.responseText))

    @$el

  renderJSONErrors: ->
    $('<ul/>').append(
      _.map(
        @options.responseJSON.errors, @renderJSONError
      )
    )

  renderJSONError: (message) ->
    li = $('<li/>')

    if message.indexOf('|')# || message.indexOf('\n')
      li.append(new TraceView(message: message).render())
    else
      li.text(message)

    li

class TraceView extends Backbone.View
  events:
    'click .expand': 'expand'

  expand: ->
    @options.expanded = true
    @$el.empty()
    @render()

  render: ->
    message = @options.message
    split = splitAtFirst(message, "\n")

    if split[0].match(/\/(present|future)/)
      title = split[0].trim().split('/', 2)
      title[0] = "<strong>#{title[0]}</strong>"
      split[0] = title.join('/')
    else if split[0].slice(0, 11) == 'SyntaxError'
      split[0] = split[0].replace(/in (\w+)/g, 'in <code>$1</code>')

    @$el.append(
      $('<h2/>').html(split[0]),
      @renderTrace(split[1])
    )

  renderTrace: (trace) ->
    return null unless trace && trace.trim().length

    # Query syntax errors separate the error title from the backtrace with a
    # pipe character.
    split = trace.trim().split(/\n/)
    expander = null

    unless @options.expanded
      expander = $('<span class="expand"/>').html('&middot;&middot;&middot;')
      split = split.slice(0, 6)

    # Highlight substring in the first backtrace lines which refers to queries
    # or inputs.
    split = split.map (line) ->
      line.replace(
        /(etsource\/(?:inputs|gqueries).*?): /g,
        '<strong>$1</strong>: '
      )

    $('<div class="trace"/>').append(
      $('<pre/>').html(split.join("\n")),
      expander
    )

