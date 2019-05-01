((root, factory) ->
	if typeof define == 'function' and define.amd
#AMD
		define [ 'jquery' ], factory
	else if typeof exports == 'object'
#CommonJS
		$ = requie('jquery')
		module.exports = factory($)
	else
#都不是，浏览器全局定义
		root.navScrollSpy = factory(root.jQuery)
	return
) window, ($) ->
	pluginName = 'jqNavScrollSpy'
	defaults =
		navItems: '.nav-item'
		scrollContainer: 'html,body'
		spyItems: '.spy-item'
		easing: 'swing'
		speed: 550
	jqNavScrollSpy = do ->
		`var jqNavScrollSpy`
		#初始化
		
		jqNavScrollSpy = (element, configs) ->
			@_element = element
			@$win = $(window)
			@defaults = $.extend({}, defaults, configs)
			@init()
			return
		
		jqNavScrollSpy::init = ->
			@$navItems = $(@defaults.navItems)
			@$spyItems = $(@defaults.spyItems)
			@$scrollContainer = $(@defaults.scrollContainer)
			@fixTop = $(@$spyItems[0]).offset().top
			#修正初始化的时候元素距离顶部的距离不等于滚动的距离的变量，也就是减去第一个元素距离顶部的高度
			@spyItemsData = @getSpyItemsData()
			@spyScroll()
			@clickSwitch()
			return
		
		#监听滚动事件
		
		jqNavScrollSpy::spyScroll = ->
			@$win.on 'scroll', @throttle(@scrollCallBack, 100, 200)
			return
		
		#滚动监听的回调函数
		
		jqNavScrollSpy::scrollCallBack = ->
			spyIndex = @getVisibleElIndex()
			@changeNav @$navItems[spyIndex]
			return
		
		#存储监视滚动元素的中心位置数组
		
		jqNavScrollSpy::getSpyItemsData = ->
			_this_1 = this
			spyItemsData = []
			@$spyItems.each (index) ->
				spyItemsData[index] = (_this_1.getOffsetTop(index) + _this_1.getOffsetTop(index) + $(_this_1.$spyItems[index]).height()) / 2
				return
			spyItemsData
		
		#获得当前滚动到视图区的元素的索引
		
		jqNavScrollSpy::getVisibleElIndex = ->
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
		
		#节流函数
		
		jqNavScrollSpy::throttle = (func, wait, mustRun) ->
			timeout = undefined
			context = this
			startTime = new Date
			->
				args = arguments
				curTime = new Date
				clearTimeout timeout
				# 如果达到了规定的触发时间间隔，触发 handler
				if curTime - startTime >= mustRun
					func.apply context, args
					startTime = curTime
# 没达到触发间隔，重新设定定时器
				else
					timeout = setTimeout(func.bind(context), wait)
				return
		
		#点击切换
		
		jqNavScrollSpy::clickSwitch = ->
			_this = this
			@$navItems.on 'click', ->
				_this.changeNav this
				navIndex = $(this).index()
				_this.$win.off 'scroll'
				_this.scrollIntoView navIndex
				return
			return
		
		#改变导航active
		
		jqNavScrollSpy::changeNav = (currentNav) ->
			@$navItems.removeClass 'active'
			$(currentNav).addClass 'active'
			return
		
		#滚动到可视区
		
		jqNavScrollSpy::scrollIntoView = (navIndex) ->
			_this_1 = this
			offsetTop = parseInt(@getOffsetTop(navIndex))
#			if !@$scrollContainer.is(':animated')
			@$scrollContainer.stop().animate { 'scrollTop': offsetTop }, @defaults.speed, @defaults.easing, ->
#动画结束后重新注册滚动监听事件
					_this_1.spyScroll()
					return
			return
		
		#获取滚动元素距离顶部的距离
		
		jqNavScrollSpy::getOffsetTop = (index) ->
			parseInt($(@$spyItems[index]).offset().top) - parseInt(@fixTop)
		
		jqNavScrollSpy
	
	$.fn.navActiveAnimate = (configs) ->
		@each ->
			if !$.data(this, 'plugin_' + pluginName)
				$.data this, 'plugin_' + pluginName, new jqNavScrollSpy(this, configs)
			else
				$.data this, 'plugin_' + pluginName, null
				$.data this, 'plugin_' + pluginName, new jqNavScrollSpy(this, configs)
			return
	
	return

# ---
# generated by js2coffee 2.2.0