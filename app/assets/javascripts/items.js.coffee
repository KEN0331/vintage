# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'change', '#category_id', ->
  $.ajax(
    type: 'GET'
    url: '/admin/items/subcategory'
    data: {
      category_id: $(this).val()
    }
  )
  

$(document).on 'change', '#item_type_id', ->
  $.ajax(
    type: 'GET'
    url: '/admin/items/units'
    data: {
      item_type_id: $(this).val()
    }
  )