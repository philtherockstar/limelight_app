# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready_home = -> 
  if url == undefined 
    url = window.location.href
  console.log("url=" + url)
  p = $('#prop_addr')
  #console.log(p)
  if (p.length > 0)
    console.log('no prop addr')
    $('#prop_addr').autocomplete(
      minLength: 2
      source:'/property/search'
      select: (event,ui) ->
        console.log('ui ' + ui.item.address)
        $('#prop_id').val(ui.item.id)
        $('#prop_addr').val(ui.item.address)
        $("#home_form_prop_addr_group").removeClass('has-error').addClass('has-success')
        $('.help-block').html("Success!")
        false
      ).data('ui-autocomplete')._renderItem = ( ul, item ) ->
        $( "<li>" )
          .data( "item.autocomplete", item)
          .append( item.address + " " + item.city )
          .appendTo( ul )
  $('form').on 'keyup', (e) -> 
    #console.log('key: ' + e.which)
    if e.which == 13
      #console.log('enter!')
      e.preventDefault
      return false

  $('#home_choose_property_go_button').click (e) ->
    console.log('home_choose_property_go_button clicked')
    my_bid = $('input[name=bid]:checked').val() 
    if (my_bid?)
      console.log("my_bid=#{my_bid}")
      $("#home_form_choose_prop_group").removeClass('has-error').addClass('has-success')
      $('.help-block').html("Success!")
      console.log('yes')
      $('form').submit()
    else
      console.log("my_bid undefined")
      $("#home_form_choose_prop_group").removeClass('has-success').addClass('has-error')
      $('.help-block').html("Please select one of the options")


  $('#home_go_button').click (e) ->
    console.log('home_go_button clicked')
    prop_id=$("#prop_id").val()
    console.log("prop_id=#{prop_id}")
    if prop_id is '0'
      console.log('no')
      $("#home_form_prop_addr_group").removeClass('has-success').addClass('has-error')
      $('.help-block').html("The address field doesn't have a valid address")
    else
      $("#home_form_prop_addr_group").removeClass('has-error').addClass('has-success')
      $('.help-block').html("Success!")
      console.log('yes')
      $('form').submit()

ready_consultations = ->
  $('#property_city').change ->
    console.log("state_id=#{property_state_id}")
    $.ajax
      url: "/property/search"
      data:
        address: $('#property_address').val()
        city: $(@).val()
        state_id: $('#property_state_id').val()
      success: (data,status,response) ->
        if data.error == true
          console.log('success but error')
        else
          if data.length > 0 
            console.log('got addr')
            $("#consultations_prop_addr_group").removeClass('has-success').addClass('has-error')
            $("#consultations_prop_city_group").removeClass('has-success').addClass('has-error')
            $('.help-block').html("This property is already in the database")
          else
            console.log('address not found')
            $("#consultations_prop_addr_group").removeClass('has-error').addClass('has-success')
            $("#consultations_prop_city_group").removeClass('has-error').addClass('has-success')
            $('.help-block').html("")
      error: ->
        console.log('error')
      dataType: "json"
  $('#property_sqft').change ->
    sqft=$(@).val()
    if isFinite(sqft) and parseInt(sqft) < 20000
      console.log("sqft=#{sqft}")
      $("#consultations_prop_sqft_group").removeClass('has-error').addClass('has-success')
      $('.help-block').html("")
    else
      $("#consultations_prop_sqft_group").removeClass('has-success').addClass('has-error')
      $('.help-block').html("Square Feet must be a number < 20,000")

  $('#client_first_name').autocomplete(
    minLength: 2
    source:'/client/search'
    select: (event,ui) ->
      console.log('ui ' + ui.item.first_name)
      $('#client_id').val(ui.item.id)
      $('#client_first_name').val(ui.item.first_name)
      $('#client_last_name').val(ui.item.last_name)
      $('#client_phone').val(ui.item.phone)
      $('#client_email').val(ui.item.email)
      false
    ).data('ui-autocomplete')._renderItem = ( ul, item ) ->
      $( "<li>" )
        .data( "item.autocomplete", item)
        .append( item.first_name + " " + item.last_name )
        .appendTo( ul )
  $('#realtor_first_name').autocomplete(
    minLength: 2
    source:'/realtor/search'
    select: (event,ui) ->
      console.log('ui ' + ui.item.address)
      $('#realtor_id').val(ui.item.id)
      $('#realtor_first_name').val(ui.item.first_name)
      $('#realtor_last_name').val(ui.item.last_name)
      $('#realtor_phone').val(ui.item.phone)
      $('#realtor_email').val(ui.item.email)
      false
    ).data('ui-autocomplete')._renderItem = ( ul, item ) ->
      $( "<li>" )
        .data( "item.autocomplete", item)
        .append( item.first_name + " " + item.last_name)
        .appendTo( ul )
  $('#consultations_save_button').click (e) ->
    console.log('consultations_save_button clicked')
    $('#consultations_form').submit()

ready_step1 = -> 
  $('#property_city').change ->
    console.log("state_id=#{property_state_id}")
    $.ajax
      url: "/property/search"
      data:
        address: $('#property_address').val()
        city: $(@).val()
        state_id: $('#property_state_id').val()
      success: (data,status,response) ->
        if data.error == true
          console.log('success but error')
        else
          if data.length > 0 
            console.log('got addr')
            $("#bids_step1_prop_addr_group").removeClass('has-success').addClass('has-error')
            $("#bids_step1_prop_city_group").removeClass('has-success').addClass('has-error')
            $('.help-block').html("This property is already in the database")
          else
            console.log('address not found')
            $("#bids_step1_prop_addr_group").removeClass('has-error').addClass('has-success')
            $("#bids_step1_prop_city_group").removeClass('has-error').addClass('has-success')
            $('.help-block').html("")
      error: ->
        console.log('error')
      dataType: "json"
  $('#property_sqft').change ->
    sqft=$(@).val()
    if isFinite(sqft) and parseInt(sqft) < 20000
      console.log("sqft=#{sqft}")
      $("#bids_step1_prop_sqft_group").removeClass('has-error').addClass('has-success')
      $('.help-block').html("")
    else
      $("#bids_step1_prop_sqft_group").removeClass('has-success').addClass('has-error')
      $('.help-block').html("Square Feet must be a number < 20,000")

  $('#client_first_name').autocomplete(
    minLength: 2
    source:'/client/search'
    select: (event,ui) ->
      console.log('ui ' + ui.item.first_name)
      $('#client_id').val(ui.item.id)
      $('#client_first_name').val(ui.item.first_name)
      $('#client_last_name').val(ui.item.last_name)
      $('#client_phone').val(ui.item.phone)
      $('#client_email').val(ui.item.email)
      false
    ).data('ui-autocomplete')._renderItem = ( ul, item ) ->
      $( "<li>" )
        .data( "item.autocomplete", item)
        .append( item.first_name + " " + item.last_name )
        .appendTo( ul )
  $('#realtor_first_name').autocomplete(
    minLength: 2
    source:'/realtor/search'
    select: (event,ui) ->
      console.log('ui ' + ui.item.address)
      $('#realtor_id').val(ui.item.id)
      $('#realtor_first_name').val(ui.item.first_name)
      $('#realtor_last_name').val(ui.item.last_name)
      $('#realtor_phone').val(ui.item.phone)
      $('#realtor_email').val(ui.item.email)
      false
    ).data('ui-autocomplete')._renderItem = ( ul, item ) ->
      $( "<li>" )
        .data( "item.autocomplete", item)
        .append( item.first_name + " " + item.last_name)
        .appendTo( ul )
  $('#step1_next_button').click (e) ->
    console.log('step1_next_button clicked')
    $('#step1_form').submit()

ready_step2 = ->
  calc_room_total = () ->
    console.log("calculating room total")
    sum = 0
    $('.bid_room_fee_total').each (index,element)=>
      sum += parseFloat($(element).text())
      $('.bid_rooms_fee').text(sum)
  calc_room_total()
  $('.number_of_rooms').change ->
    num_rooms = $(@).val()
    id = $(@).attr('id').match(/.*_(\d*)/)[1]
    console.log("number of rooms changed for " + id )
    if isFinite(num_rooms) and parseInt(num_rooms) < 11
      $("#bids_step2_room_number_group_#{id}").removeClass('has-error').addClass('has-success')
      $('.help-block').html("")
    else
      $("#bids_step2_room_number_group_#{id}").removeClass('has-success').addClass('has-error')
      $('.help-block').html("Room Number must be a number <= 10")
      $('#help-block').css("color:red")
      $(@).focus()
      return false
    room_price = $("#room_prices_" + id).val()
    $("#bid_room_fee_total_" + id).text(num_rooms * room_price)
    calc_room_total()
  $('.room_prices').change ->
    room_price = $(@).val()
    id = $(@).attr('id').match(/.*_(\d*)/)[1]
    console.log("room price changed for " + id )
    console.log("room price is " + room_price)
    if isFinite(room_price) and parseInt(room_price) < 20000
      $("#bids_step2_room_price_group_#{id}").removeClass('has-error').addClass('has-success')
      $('.help-block').html("")
    else
      $("#bids_step2_room_price_group_#{id}").removeClass('has-success').addClass('has-error')
      $('.help-block').html("Room Price must be a number <= 20,000")
      $('#help-block').addClass("error")
      $(@).focus()
      return false
    num_rooms = $("#rooms_" + id).val()
    console.log("number of rooms is " + num_rooms)
    $("#bid_room_fee_total_" + id).text(room_price * num_rooms)
    calc_room_total()
  $('#step2_next_button').click (e) ->
    console.log('step2_next_button clicked')
    submitme=true
    $('.number_of_rooms').each ->
      num_rooms=$(@).val()
      console.log(parseInt(num_rooms))
      id = $(@).attr('id').match(/.*_(\d*)/)[1]
      if isFinite(num_rooms) and parseInt(num_rooms) < 11
        x=0
      else
        $("#bids_step2_room_number_group_#{id}").removeClass('has-success').addClass('has-error')
        $('.help-block').html("Room Number must be a number <= 10")
        submitme=false
        return false
    $('.number_prices').each ->
      room_price=$(@).val()
      id = $(@).attr('id').match(/.*_(\d*)/)[1]
      if isFinite(room_price) and parseInt(room_price) < 20000
        x=0
      else
        $("#bids_step2_room_price_group_#{id}").removeClass('has-success').addClass('has-error')
        $('.help-block').html("Room Price must be a number <= 20,000")
        submitme=false
        return false
    if submitme 
      $('#step2form').submit()
  
  $('form').on 'keyup', (e) -> 
    #console.log('key: ' + e.which)
    if e.which == 13
      #console.log('enter!')
      e.preventDefault
      return false

ready_step3 = ->
  calc_total = () ->
    console.log("calculating total")
    sum = 0
    $('.bid_room_item_total').each (index,element)=>
      sum += parseFloat($(element).text())
    staging_fee = parseFloat($("#bid_staging_fee").val())
    distribution_fee = parseFloat($("#bid_distribution_fee").val())
    rental_weeks = parseFloat($("#bid_weeks_included").val())
    $(".total_rental_cost").text(sum)
    $(".weekly_rental_cost").text(sum/4)
    staging_total = parseFloat((staging_fee + distribution_fee) + ((sum/4)*rental_weeks))
    $(".bid_staging_total").text(staging_total)
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
  $('#bid_staging_fee').change ->
    calc_total()
  $('#bid_distribution_fee').change ->
    calc_total()
  $('#bid_weeks_included').change ->
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
                  <input class='bid_room_item_rental_price' id='bid_rooms_item_rental_price_#{room_id}_#{room_number}_#{new_row_number}' name='bid_rooms_item_rental_price[#{room_id}][#{room_number}][0]' size='5' type='text' value='0'>
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

load_my_js = ->
  url = window.location.href
  if url.match(/step1/)
    console.log('matched step 1')
    ready_step1()
  else if url.match(/step2/) 
    console.log('matched step 2')
    ready_step2()
  else if url.match(/step3/)
    console.log('matched step 3')
    ready_step3()
  else if url.match(/bids\/edit/)
    console.log('I matched bids/edit')
    ready_step1()
  else if url.match(/consultations\/[\d*][\/*][new|edit]/)
    console.log('I matched consultations/new or edit')
    ready_consultations()
  else
    console.log('no url matched')
    ready_home()

$(document).on('page:change', load_my_js )



