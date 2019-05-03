### var ###
$page       = $('html,body')
$height     = $(window).height()

jQuery(window).on 'load', ( e ) ->
	console.log e.type
	$page.navActiveAnimate({
		speed: 1500,
		easing: 'easeInOutCirc',
		scrollContainer: 'html,body',
		navItems: '.nav-item',
		spyItems: '.spy-item'
	});
	
	$( '#full-background').fullBackground('init')





jQuery(window).on 'resize', ( e ) ->
	console.log e.type
	if window.innerWidth > 1023
		isMobile $( '#full-background').fullBackground('init')
	


jQuery(document).on 'scroll', ( e ) ->
	console.log $( e.target ).scrollTop()
	$page.stop()
	

	

jQuery(document).on 'click', ( e ) ->
	console.log e.type


	
	
jQuery(document).on 'touchmove', ( e ) ->
	console.log e.type
	