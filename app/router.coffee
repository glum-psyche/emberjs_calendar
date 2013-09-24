App = require 'app'

App.Router.map ->
	@route 'date', { path: 'year/:year/month/:month/day/:day' }
  # put your routes here