do($ = window.jQuery, window) ->

	# Define the plugin class
	class Plugin

		defaults:
			slide: true
			style: true
			convert: true

		constructor: (el, options) ->
			@options 			= $.extend({}, @defaults, options)
			@$el 	            = $(el)
			@$height            = $( window ).height()
			@$EventsList 	    = 'touchmove mousemove touchstart mousedown mouseup'
			# GLOBAL VAR
			@$cxSave 			= 0
			@$offsetSave 			= 0
			@$slideStart 	    = true

		# Additional plugin methods go here
		init: ->
			do @fullBg
			do @drag
			do @_behave
		
		
		fullBg: ->
			if navigator.userAgent.match(/Android|iPad|iPhone/i)
				@$el.height @$height
		
				
		drag: ->
			@$el.bind @$EventsList, ( jQueryEvent ) ->
#				console.log jQueryEvent.type
				$( jQueryEvent.target ).html jQueryEvent.type
				.css
					fontSize: '50px',
					color: 'white'
				# LOCAL VAE
				$cx    = jQueryEvent.clientX
				$event = window.event
				$touch = true
				
				if jQueryEvent.type is 'mousedown'
					jQueryEvent.preventDefault()
				
				if jQueryEvent.type in ['touchstart', 'mousedown']
					@$slideStart 	= true
				

				if $event.touches
					$cx = $event.touches[0].clientX
				
					
				if @$slideStart
					@$cxSave = $cx
					@$offsetSave = $(jQueryEvent.target).parent().offset().left
					@$slideStart = false
				
					
				distance = $cx - @$cxSave + @$offsetSave
				

				if $cx is jQueryEvent.clientX
					$touch = jQueryEvent.which == 1 and @$cxSave > 0
				
					
				if $touch
					$(jQueryEvent.target).parent().css
						transform: "translateX(#{ distance }px)"
		
		
		_behave: ->
			wwe = 0
			@$el.children().each ( k, v ) ->
				wwe += $(v).outerWidth()
			console.log wwe
		
		_convert: ->
		
		
		_style: ->
	

	# Define the plugin
	$.fn.extend fullBackground: (option, args...) ->
		@each ->
			$this = $(this)
			data = $this.data('fullBackground')

			if !data
				$this.data 'fullBackground', (data = new Plugin(this, option))
				do data.init
			if typeof option == 'string'
				data[option].apply(data, args)
