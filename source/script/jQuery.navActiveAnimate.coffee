((root, factory) ->
	if typeof define == 'function' and define.amd
		#AMD
		define [ 'jquery' ], factory
	else if typeof exports == 'object'
		$ = requie('jquery')
		module.exports = factory($)
	else
		# No, global browser definition
		root.navScrollSpy = factory(root.jQuery)
	return
) window, ($) ->
	pluginName = 'navActiveAnimate'
	defaults =
		navItems: '.nav-item'
		scrollContainer: 'html,body'
		spyItems: '.spy-item'
		easing: 'swing'
		speed: 550
	navActiveAnimate = do ->
		`var navActiveAnimate`
		#init
		
		navActiveAnimate = (element, configs) ->
			@_element = element
			@$win = $(window)
			@defaults = $.extend({}, defaults, configs)
			@init()
			return
		
		navActiveAnimate::init = ->
			@$navItems = $(@defaults.navItems)
			@$spyItems = $(@defaults.spyItems)
			@$scrollContainer = $(@defaults.scrollContainer)
			@fixTop = $(@$spyItems[0]).offset().top
			###
            Correct the variable when the distance from
            the top of the element is not equal to the scroll
            distance during initialization, that is, subtract the
            height of the first element from the top
            ###
			@spyItemsData = @getSpyItemsData()
			@spyScroll()
			@clickSwitch()
			return
		
		#Listen to scroll events
		
		navActiveAnimate::spyScroll = ->
			@$win.on 'scroll', @throttle(@scrollCallBack, 100, 200)
			return
		
		#Callback function for scrolling listeners
		
		navActiveAnimate::scrollCallBack = ->
			spyIndex = @getVisibleElIndex()
			@changeNav @$navItems[spyIndex]
			return
		
		#Storage of an array of central locations to control scrollable items
		
		navActiveAnimate::getSpyItemsData = ->
			_this_1 = this
			spyItemsData = []
			@$spyItems.each (index) ->
				spyItemsData[index] = (_this_1.getOffsetTop(index) + _this_1.getOffsetTop(index) + $(_this_1.$spyItems[index]).height()) / 2
				return
			spyItemsData
		
		#Get the index of the item currently scrolling to the viewport.
		
		navActiveAnimate::getVisibleElIndex = ->
			_this_1 = this
			spyIndex = undefined
			scrollTop = parseInt(@$win.scrollTop())
			$.each @spyItemsData, (index) ->
				if _this_1.spyItemsData[0] >= scrollTop
					spyIndex = 0
					return true
				else if _this_1.spyItemsData[index] <= scrollTop and scrollTop <= _this_1.spyItemsData[index + 1]
					spyIndex = index + 1
					return true
				return
			spyIndex
		
		#Throttling function
		
		navActiveAnimate::throttle = (func, wait, mustRun) ->
			timeout = undefined
			context = this
			startTime = new Date
			->
				args = arguments
				curTime = new Date
				clearTimeout timeout
				# Trigger Handler, if the specified start interval is reached
				if curTime - startTime >= mustRun
					func.apply context, args
					startTime = curTime
					# Reset the timer without reaching the start interval
				else
					timeout = setTimeout(func.bind(context), wait)
				return
		
		#Click to switch
		
		navActiveAnimate::clickSwitch = ->
			_this = this
			@$navItems.on 'click', ->
				_this.changeNav this
				navIndex = $(this).index()
				_this.$win.off 'scroll'
				_this.scrollIntoView navIndex
				return
			return
		
		#Change navigation active
		
		navActiveAnimate::changeNav = (currentNav) ->
			@$navItems.removeClass 'active'
			$(currentNav).addClass 'active'
			return
		
		#Scroll to viewport
		
		navActiveAnimate::scrollIntoView = (navIndex) ->
			_this_1 = this
			offsetTop = parseInt(@getOffsetTop(navIndex))
#			if !@$scrollContainer.is(':animated')
			@$scrollContainer.stop().animate { 'scrollTop': offsetTop }, @defaults.speed, @defaults.easing, ->
					#Reregister the scroll listen event after the animation ends
					_this_1.spyScroll()
					return
			return
		
		#Get the distance of the scroll item on top
		
		navActiveAnimate::getOffsetTop = (index) ->
			parseInt($(@$spyItems[index]).offset().top) - parseInt(@fixTop)
		
		navActiveAnimate
	
	$.fn.navActiveAnimate = (configs) ->
		@each ->
			if !$.data(this, 'plugin_' + pluginName)
				$.data this, 'plugin_' + pluginName, new navActiveAnimate(this, configs)
			else
				$.data this, 'plugin_' + pluginName, null
				$.data this, 'plugin_' + pluginName, new navActiveAnimate(this, configs)
			return
	
	return