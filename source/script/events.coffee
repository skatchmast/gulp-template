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
	
	$( '.full-background-inner').fullBackground()





jQuery(window).on 'resize', ( e ) ->
	console.log e.type
#	if window.innerWidth > 1023
#		isMobile $( '#full-background').fullBackground('init')
#	isMobile $( '.full-background-item').fullBackground('init')
	


jQuery(document).on 'scroll', ( e ) ->
#	console.log $( e.target ).scrollTop()
	$page.stop()




jQuery(document).on 'click', ( e ) ->
	e.preventDefault()



#x = 0
#y = 0
#slideStart = true


#$('.full-background-inner').bind 'touchmove mousemove touchstart mousedown', ( jQueryEvent ) ->
#	if jQueryEvent.type is 'mousedown'
#		jQueryEvent.preventDefault()
#
#
#	jQueryEvent.stopPropagation()
#
#	if jQueryEvent.type is 'touchstart' or jQueryEvent.type is 'mousedown'
#		slideStart = true
#
#	event = window.event
#
#	cx =  jQueryEvent.clientX
#
#	if jQueryEvent.originalEvent.touches
#		cx = jQueryEvent.originalEvent.touches[0].clientX
#
#	if  slideStart
#		x = cx
#		y = $(jQueryEvent.target).parent().offset().left
#		slideStart = false
#
#	distance = cx  - x + y
#
#	touch = true
#	if cx is jQueryEvent.clientX
#		touch = jQueryEvent.which == 1 and x > 0
#
#	if touch
#		$(jQueryEvent.target).parent().css
#			transform: "translate(#{ distance }px,0)"