window.Actions ||= {}


Actions.initExampleActions = ->
  $('#example_elements').on 'click', '.add-element', (e) ->
    e.preventDefault()
    App.addToList this, '.elements_container'
    return
  $('#example_elements').on 'click', '.remove-element', (e) ->
    e.preventDefault()
    App.removeFromList this, '.element'
    return