App = require 'app'

App.DateRoute = Ember.Route.extend

	serialize: (aValue) -> 
		{
			year: aValue.year
			month: aValue.month
			day: aValue.day
		}

	setupController: (controller, params, model)->
		controller.setDate params