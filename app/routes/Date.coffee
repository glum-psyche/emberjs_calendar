App = require 'app'

App.DateRoute = Ember.Route.extend

	serialize: (aValue) -> 
		{
			year: aValue.year
			month: aValue.month
			day: aValue.day
		}

	setupController: (controller, params, model)->
		year = parseInt params.year, 10
		month =  parseInt params.month, 10
		day = parseInt params.day, 10
		if month < 1 or month > 12
			month = 1 if month < 1
			month = 12 if month > 12

		lastDate = new Date year, month, 0
		lastDay = lastDate.getDate()

		if day < 1 or day > lastDay
			day = 1 if day < 1
			day = lastDay if day > lastDay

		newParams = {year: year, month: month, day: day}
		controller.setDate newParams