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
	
#	$( '#full-background').fullBackground('init')
#	$( '.full-background-item').fullBackground('init')





jQuery(window).on 'resize', ( e ) ->
	console.log e.type
#	if window.innerWidth > 1023
#		isMobile $( '#full-background').fullBackground('init')
#	isMobile $( '.full-background-item').fullBackground('init')
	


jQuery(document).on 'scroll', ( e ) ->
	console.log $( e.target ).scrollTop()
	$page.stop()




jQuery(document).on 'click', ( e ) ->
	e.preventDefault()



x = 0
y = 0
a = 0
$('.full-background-inner').on 'mousedown', ( e ) ->
	e.preventDefault()
	
	console.log e.type
	x = e.clientX
	y = $(e.target).parent().offset().left



$('.full-background-inner').on 'mousemove', ( e ) ->
	e.preventDefault()
	console.log $(e.target).parent().offset().left
	offs = e.clientX - x + y
	
	if e.which == 1 and x > 0
		$(e.target).parent().css
			transform: "translate(#{ offs }px,0)"

ui =true
$('.full-background-inner').bind 'touchstart', (jQueryEvent) ->
	ui =true


$('.full-background-inner').bind 'touchmove', (jQueryEvent) ->
	jQueryEvent.preventDefault()
	event = window.event
	$(jQueryEvent.target).html 'x=' + event.touches[0].pageX + '  --- ' + $(jQueryEvent.target).parent().offset().left
	
#	ui =true
	if  ui
		x = event.touches[0].pageX
		y = $(jQueryEvent.target).parent().offset().left
		ui = false
	
	offs = event.touches[0].pageX - x + y
	
	$(jQueryEvent.target).parent().css
		transform: "translate(#{ offs }px,0)"