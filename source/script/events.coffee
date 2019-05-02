### var ###
page = $('html,body')

jQuery(window).on 'load', ( e ) ->
	console.log e.type
#	$( '#full-background').fullBackground('init')
	
	page.navActiveAnimate({
			speed: 1500,
			easing: 'easeInOutCirc',
			scrollContainer: 'html,body',
			navItems: '.nav-item',
			spyItems: '.spy-item'
		});




jQuery(window).on 'resize', ( e ) ->
	console.log e.type
#	$( '#full-background').fullBackground('init')

	


jQuery(document).on 'scroll', ( e ) ->
	console.log $( e.target ).scrollTop()
	page.stop()
	

	

jQuery(document).on 'click', ( e ) ->
	console.log e.type


	
	
jQuery(document).on 'touchmove', ( e ) ->
	console.log e.type
	