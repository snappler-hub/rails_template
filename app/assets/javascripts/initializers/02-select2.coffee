jQuery.fn.ajaxSelect = (options) ->
 if ! $(this).data('select2')
   url = $(this).data('url')
   placeholder = $(this).data('placeholder')
   allow_clear = $(this).data('allow-clear')
   new_button = $(this).data('new-button')


   defaults =
     formatter: (record) ->
       record.full_text || record.name
     result_formatter: (record, container, query, escapeMarkup) ->
       markup = []
       text = settings.format_name(record)
       Select2.util.markMatch(text, query.term, markup, escapeMarkup)
       markup = markup.join("")
       markup = "<div class='select2-main-text'> #{markup} </div>"
       if record.extra
         markup += settings.format_extra(record)

       return markup
     format_name: (record) ->
       record.full_text || record.name
     format_extra: (record) ->
       return "<small class='select2-extra-text'> #{record.extra} </small>"

     allow_clear: true
     selectData: (term, page)->
       query: term
       limit: 10
       page: page

   settings = $.extend(defaults, options)

   if new_button == undefined
    format_no_matches = $.fn.select2.locales['es']['formatNoMatches']
   else
    format_no_matches = () ->
      new_button

   this.select2
     formatNoMatches: format_no_matches
     initSelection: (elm, callback) ->
       data =
         id: $(elm).data "record-id"
         name: $(elm).data "record-text"
       callback(data)
     placeholder: placeholder
     allowClear: allow_clear
     minimumInputLength: 2
     ajax:
       url: url
       dataType: "json"
       quietMillis: 100
       data: (term, page) ->
         settings.selectData(term, page)
       results: (data, page) ->
         more = (page * 10) < data.total
         results: data
         more: more
     formatResult: settings.result_formatter
     formatSelection: settings.formatter



jQuery.fn.normalSelect = (options) ->
 placeholder = $(this).data('placeholder')
 allow_clear = $(this).data('allow-clear')

 defaults =

 settings = $.extend(defaults, options)

 this.select2
   placeholder: placeholder
   allowClear: allow_clear

