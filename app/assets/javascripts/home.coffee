# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = -> 
  if url == undefined 
    url = window.location.href
  console.log("url=" + url)
  if url.match(/home|bid|pricing/)
    x="dummy"
  else
    if $('#prop_addr')?
      console.log('got prop addr')
    else
      console.log('no prop addr')
    $('#prop_addr').autocomplete(
      minLength: 2
      source:'/properties/search'
      select: (event,ui) ->
        console.log('ui ' + ui.item.address)
        $('#prop_id').val(ui.item.id)
        $('#prop_addr').val(ui.item.address)
        false
      ).data('ui-autocomplete')._renderItem = ( ul, item ) ->
        $( "<li>" )
          .data( "item.autocomplete", item)
          .append( item.address + " " + item.city )
          .appendTo( ul )

$(document).on('page:change', ready)