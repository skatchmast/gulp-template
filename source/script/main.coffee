do($ = window.jQuery, window) ->

	# Define the plugin class
	class Plugin
		
		defaults:
			fullEl: window
		
		constructor: (el, options) ->
			@options = $.extend({}, @defaults, options)
			@$el = $(el)
			do @init

		# Additional plugin methods go here
		init: ( ) ->
			@$el.css
				height: "#{$(@options.fullEl).height()}px"
	
	# Define the plugin
	$.fn.extend fullBackground: (option, args...) ->
		@each ->
			$this = $(this)
			data = $this.data('fullBackground')
			
			if !data
				$this.data 'fullBackground', (data = new Plugin(this, option))
			if typeof option == 'string'
				data[option].apply(data, args)