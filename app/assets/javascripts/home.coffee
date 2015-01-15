# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = -> 
  calc_total = () ->
    console.log("calculating total")
    sum = 0
    $('.bid_room_item_total').each (index,element)=>
      sum += parseFloat($(element).text())
    $(".total_rental_cost").text(sum)
    $(".weekly_rental_cost").text(sum/4)
  calc_total()
  $('form').on 'keyup', (e) -> 
    #console.log('key: ' + e.which)
    if e.which == 13
      #console.log('enter!')
      e.preventDefault
      return false
  $('.items_form_button').click (e) ->
    #console.log('items_form_button clicked')
    $('#items_form_action').val($(@).attr('name'))
    #console.log('my name= ' + $(@).attr('name') )
    $('form').submit()
  $('.bid_room_item_quantity').change ->
    qty = $(@).val()
    id = $(@).attr('id').match(/.*_(\d*_\d*_\d*)/)[1]
    console.log("quantify changed for " + id )
    rental_price = $("#bid_rooms_item_rental_price_" + id).val()
    $("#bid_rooms_item_total_" + id).text(qty * rental_price)
    calc_total()
  $('.bid_room_item_rental_price').change ->
    rental_price = $(@).val()
    id = $(@).attr('id').match(/.*_(\d*_\d*_\d*)/)[1]
    console.log("rental changed for " + id )
    qty = $("#bid_rooms_item_quantity_" + id).val()
    $("#bid_rooms_item_total_" + id).text(qty * rental_price)
    calc_total()

  $('.add_item_to_rooms').click (e) -> 
    console.log("clicked .add_item_to_room button. creating new row")
    console.log("e.which = " + e.which )
    e.preventDefault()
    room_id = $(@).data("room-id")
    room_number = $(@).data("room-number")
    last_row_number=$(".room_"+room_id+"_"+room_number+":last").data("row-number")
    new_row_number=last_row_number+1
    newrow = """
              <div id='row_#{room_id}_#{room_number}_#{new_row_number}' class='table_row room_#{room_id}_#{room_number}' data-room-id='#{room_id}' data-room-number='#{room_number}' data-row-number='#{new_row_number}'>
                <div class='table_cell'>
                  <input class='bid_room_item' id='bid_rooms_item_#{room_id}_#{room_number}_#{new_row_number}' name='bid_rooms_item[#{room_id}][#{room_number}][0]' size='20' type='text' placeholder='Enter New Item:' data-room-id='#{room_id}' data-room-number='#{room_number}' data-row-number='#{new_row_number}'>
                </div>
                <div class='table_cell'>
                  <input class='bid_room_item_quantity' id='bid_rooms_item_quantity_#{room_id}_#{room_number}_#{new_row_number}' name='bid_rooms_item_quantity[#{room_id}][#{room_number}][0]' size='3' type='text' value='0'>
                </div>
                <div class='table_cell'>
                  <input class='bid_room_item_rental_price' id='bid_rooms_item_rental_price_#{room_id}_#{room_number}_#{new_row_number}' name='bid_rooms_item_rental_price[#{room_id}][#{room_number}][0]' size='3' type='text' value='0'>
                </div>
                <div class='table_cell bid_room_item_total' id='bid_rooms_item_total_#{room_id}_#{room_number}_#{new_row_number}'>
                  0
                </div>
              </div>
    """
    $("#row_" + room_id + "_" + room_number + "_" + last_row_number).after(newrow)
    $('#bid_rooms_item_' + room_id + "_" + room_number + "_" + new_row_number).autocomplete(
      minLength: 2
      source: '/item',
      select: (event,ui) -> 
        room_id=$(@).data('room-id')
        room_number=$(@).data('room-number')
        row_number=$(@).data('row-number')
        $('#bid_rooms_item_'+room_id+'_'+room_number+'_'+row_number).val(ui.item.name)
        item_name="bid_rooms_item[" + room_id + "][" + room_number + "][" + ui.item.id + "]" 
        $('#bid_rooms_item_'+room_id+'_'+room_number+'_'+row_number).attr('name',item_name)
        $('#bid_rooms_item_rental_price_'+room_id+'_'+room_number+'_'+row_number).val(ui.item.rental_price)
        qty_name="bid_rooms_item_quantity[" + room_id + "][" + room_number + "][" + ui.item.id + "]" 
        $('#bid_rooms_item_quantity_'+room_id+'_'+room_number+'_'+row_number).attr('name',qty_name)
        $('#bid_rooms_item_quantity_'+room_id+'_'+room_number+'_'+row_number).val(1)
        rental_name="bid_rooms_item_rental_price[" + room_id + "][" + room_number + "][" +  ui.item.id + "]" 
        $('#bid_rooms_item_rental_price_'+room_id+'_'+room_number+'_'+row_number).attr('name',rental_name)
        qty = $('#bid_rooms_item_quantity_'+room_id+'_'+room_number+'_'+row_number).val()
        $('#bid_rooms_item_total_'+room_id+'_'+room_number+'_'+row_number).text(ui.item.rental_price * qty )
        calc_total()
        false
      ).data('ui-autocomplete')._renderItem = ( ul, item ) ->
        $( "<li>" )
          .data( "item.autocomplete", item)
          .append( item.name + " $" + item.rental_price )
          .appendTo( ul )
    $('.bid_room_item_quantity').change ->
      qty = $(@).val()
      id = $(@).attr('id').match(/.*_(\d*_\d*_\d*)/)[1]
      console.log(id)
      rental_price = $("#bid_rooms_item_rental_price_" + id).val()
      console.log(rental_price)
      $("#bid_rooms_item_total_" + id).text(qty * rental_price)
      calc_total()
    $('.bid_room_item_rental_price').change ->
      rental_price = $(@).val()
      id = $(@).attr('id').match(/.*_(\d*_\d*_\d*)/)[1]
      qty = $("#bid_rooms_item_quantity_" + id).val()
      $("#bid_rooms_item_total_" + id).text(qty * rental_price)
      calc_total()

$(document).ready(ready)
$(document).on('page:load', ready)