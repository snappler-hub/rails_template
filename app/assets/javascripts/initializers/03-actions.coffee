window.Actions ||= {}


Actions.initCarActions = ->
  $('#components').on 'click', '.add-component', (e) ->
    e.preventDefault()
    App.addToList this, '.components_container'
    return
  $('#components').on 'click', '.remove-component', (e) ->
    e.preventDefault()
    App.removeFromList this, '.component'
    return
  $('#car_images').find('.file-preview-thumbnails').sortable
    revert: true
    items: '.file-preview-initial'
    stop: (event, ui) ->
      cont = ui.item.parent()
      position = []
      cont.find('.file-preview-initial .kv-file-remove').each (index) ->
        position.push 'pos[' + index + ']=' + $(this).data('key')
        return
      $.getScript '/backend/cars/order_images?' + position.join('&')
      return