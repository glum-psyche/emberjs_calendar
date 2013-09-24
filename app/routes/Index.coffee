App = require 'app'

module.exports = App.IndexRoute = Ember.Route.extend
	redirect: ()->
		currentDate = new Date()
		data = {year: currentDate.getFullYear(), month: currentDate.getMonth() + 1, day: currentDate.getDate()}
		@transitionTo 'date', data