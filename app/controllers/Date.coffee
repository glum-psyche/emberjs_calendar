App = require 'app'

App.DateController = Ember.ObjectController.extend

	weekDays: ['Sun', 'Mon', 'Tue', 'Thu', 'Fri', 'Sat']
	months: [
		'January'
		'February'
		'March'
		'April'
		'May'
		'June'
		'July'
		'August'
		'September'
		'October'
		'November'
		'December'
	]

	year: -1
	month: -1
	day: -1

	selectDay: (aDay)->
		@transitionToRoute 'date', {year: @year, month: @month, day: aDay}

	selectToday: ()->
		today = new Date()
		year = today.getFullYear()
		month = today.getMonth() + 1
		day = today.getDate()
		@transitionToRoute 'date', {year: year, month: month, day: day}

	previousMonth: ()->
		month = @month - 1
		year = @year
		if month < 1
			--year
			month = 12
		@transitionToRoute 'date', {year: year, month: month, day: @day}

	nextMonth: ()->
		month = @month + 1
		year = @year
		if month > 12
			++year
			month = 1
		@transitionToRoute 'date', {year: year, month: month, day: @day}

	previousYear: ()->
		@transitionToRoute 'date', {year: @year - 1, month: @month, day: @day}

	nextYear: ()->
		@transitionToRoute 'date', {year: @year + 1, month: @month, day: @day}

	setDate: (aData)->
		@set 'year', parseInt aData.year, 10
		@set 'month', parseInt aData.month, 10
		@set 'day', parseInt aData.day, 10
		allDays = (@get 'selectedMonthDays')
		lastWeek = allDays.length - 1
		days = []
		days = days.concat.apply days, allDays
		correctDay = @day in days.getEach 'day'
		unless correctDay
			console.log 'incorrect!!!'
			@set 'day', 1
			# @transitionToRoute 'date', {year: @year, month: @month, day: @day}

	weekDayName: (aDay)->
		@weekDays[aDay]

	selectedMonthDays: (->
		firstDate = new Date @year, @month - 1, 1
		lastDate = new Date @year, @month, 0
		today = new Date()

		currentDay = -1
		if(today.getFullYear() is @year and today.getMonth() is @month - 1)
			currentDay = today.getDate()

		lastDay = lastDate.getDate()
		firstDayOfWeek = firstDate.getDay()

		days = []
		for i in [1 .. lastDay]
			style = 'display: inline; list-style-type: none; '
			style += 'font-weight: bold; ' if i is @day
			style += 'text-decoration: underline; ' if i is currentDay
			newDay = Ember.Object.create {day: i, selected: style}
			days.push newDay
		if firstDayOfWeek > 0
			buffer = []
			for i in [0 .. firstDayOfWeek]
				style = 'display: inline; list-style-type: none; '
				newDay = Ember.Object.create {day: '_', selected: style}
				buffer.push newDay
			days[0 .. -1] = buffer

		weeks = Math.floor days.length / 7
		if days.length % 7 isnt 0
			++weeks
		out = []
		for i in [0 .. weeks - 1]
			first = i * 7
			out.push days[first .. first + 6]
		out
	).property('year', 'month', 'day')

	currentMonthName: (->
		@months[@month - 1]
	).property('month')