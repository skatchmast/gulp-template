jQuery(window).on 'load', ( e ) ->
	console.log e.type




jQuery(document).on 'resize', ( e ) ->
	console.log e.type

	


jQuery(document).on 'scroll', ( e ) ->
	console.log $( e.target ).scrollTop()
	

	

jQuery(document).on 'click', ( e ) ->
	console.log e.type