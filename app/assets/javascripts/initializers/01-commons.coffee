window.App ||= {}

App.flash_snackbar_render = (flashMessages) ->
  $.each flashMessages, (key, value) ->
    style = ''
    switch key
      when 'success'
        style = 'callout callout-success'
      when 'danger'
        style = 'callout callout-danger'
      when 'error'
        style = 'callout callout-danger'
      else
        style = 'callout'
        break
    $.snackbar
      content: value
      style: style
      timeout: 10000
    return
  return

App.initSnackbar = ->
  if $('.snackbar-message').length > 0
    $('.snackbar-message').snackbar 'show'

# Inicializa los modals con ajax
App.initModals = () ->
  links = $('[data-behavior~=ajax-modal]')
  links.on 'click', (e)->
    e.preventDefault()
    e.stopPropagation()    
    App.modalClick(this)

App.modalClick = (button) ->
  $('.select2-drop').each ->
    $(this).select2 'close'
    return
  $.getScript(button.getAttribute('href'))
  return




App.addToList = (button, container) ->
  time = (new Date).getTime()
  regexp = new RegExp($(button).data('id'), 'g')
  $(container).prepend $(button).data('fields').replace(regexp, time)
  App.init()
  return

App.removeFromList = (button, item) ->
  $(button).prev('input[type=hidden]').val '1'
  $(button).closest(item).hide()
  return





App.init = ->
  # Turbolinks progress bar
  Turbolinks.enableProgressBar()

  # Snackbar
  App.initSnackbar()

  # Ajax Modals
  App.initModals()

  # Sidebar
  $('[data-controlsidebar]').on 'click', ->
    change_layout $(this).data('controlsidebar')
    slide = !AdminLTE.options.controlSidebarOptions.slide
    AdminLTE.options.controlSidebarOptions.slide = slide
    if !slide
      $('.control-sidebar').removeClass 'control-sidebar-open'
    return

  $("[data-toggle='toggle-filter']").off('click')
  $("[data-toggle='toggle-filter']").on 'click', ->
    box = $(this).data('target')
    $(box).toggleClass('visible')

  # Select2
  $("select").normalSelect()
  $(".select_ajax").ajaxSelect()

  # Datepickers
  $('.datepicker').datetimepicker({format: 'DD/MM/YYYY', locale: 'es'})
  $('.datetimepicker').datetimepicker({format: 'DD/MM/YYYY HH:mm', locale: 'es'})

  # Al hacer clicl en un por ejemplo calendar, tambien abra el datepicker*/
  $('.input-group-addon.extend-input').on 'click', ->
    $(this).closest('div').find('input').trigger 'focus'
    return

  # Reactivo eventos de AdminLTE porque se pierden con turbolinks
  $.AdminLTE.layout.activate()
  $.AdminLTE.tree('.sidebar')

  $('.sidebar li.active').closest('.treeview').addClass('active')

  # tablas con link
  $('.tr-link td:not(.operations)').unbind 'click'
  $('.tr-link td:not(.operations)').on 'click', ->
    $(this).parent().find('.tr-link-a')[0].click()

  return


App.initActions = ->

  # Actions de forms 
  App.initCarActions('#components')

  return




App.initCarActions = (container) ->
  container = $(container)
  container.on 'click', '.add-component', (e) ->
    e.preventDefault()
    App.addToList this, '.components_container'
    return
  container.on 'click', '.remove-component', (e) ->
    e.preventDefault()
    App.removeFromList this, '.component'
    return
  return


#----------------------------- (RAILS  >= 5)
$(document).on "turbolinks:load", ->

#----------------------------- (RAILS  < 5)
#$(document).ready ->
  App.init()
  App.initActions()


# Dispara msj de flash desde js
# Ej: $(document).trigger('flash:send', {"danger":"Hola"});
$(document).on 'flash:send', (e, flashMessages) ->
  $('#snackbar-container > div').remove()
  App.flash_snackbar_render flashMessages
  return
