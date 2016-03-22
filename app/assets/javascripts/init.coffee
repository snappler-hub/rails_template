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
App.initModals = (parent) ->
  if parent
    links = parent.find('[data-behavior~=ajax-modal]')
  else
    links = $('[data-behavior~=ajax-modal]')

  links.on 'click', (e)->
    that = this
    e.preventDefault()
    e.stopPropagation()
    $.ajax
      url: this.href
    .done (data)->
      modal = $(that.getAttribute('data-target'))
      modal.addClass(that.getAttribute('data-targetClass'))
      modal.find('.modal-content').html(data)
      modal.modal("show");

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

  # Select2
  $("select").normalSelect()

  # Reactivo eventos de AdminLTE porque se pierden con turbolinks
  $.AdminLTE.layout.activate()
  $.AdminLTE.tree('.sidebar');

  $('.sidebar li.active').closest('.treeview').addClass('active')



$(document).on "page:load", ->
  App.init()

$(document).on "page:change", ->
  App.initSnackbar()
  App.initModals()
  $("select").normalSelect()


# Dispara msj de flash desde js
# Ej: $(document).trigger('flash:send', {"danger":"Hola"});
$(document).on 'flash:send', (e, flashMessages) ->
  App.flash_snackbar_render flashMessages
  return
