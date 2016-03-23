# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


	users = 10.times do User.create!(
		username: Faker::Internet.user_name,
		first_name: Faker::Name.first_name,
		last_name: Faker::Name.last_name,
		email: Faker::Internet.email,
		password: 'helloworld'
		)
	end

	users = User.all
	

	goals = ['Stay Sober', 'Get a Job', 'Get in Shape', 'Buy a House']
 	goals = goals.each do |goal|
 	  Goal.create(
 			title: goal,
 			description: Faker::Hacker.say_something_smart
  		)
  	end
  
  	goals = Goal.all

	goals = Goal.all 

	suggested_objectives = ['Call Sponsor', 'Morning Routine', 'Evening Routine', 'Meditation', 
 		           						'Therapy', 'Stepwork', 'Exercise', 'Meds', 'Relaxation', 'Read Literature', 'Create my own!']
  suggested_objectives = suggested_objectives.each do |obj|
  	SuggestedObjective.create!(title: obj)
  end

	objective = ['Call Sponsor', 'Morning Routine', 'Evening Routine', 'Meditation', 
 		           'Therapy', 'Stepwork', 'Exercise', 'Meds', 'Relaxation', 'Read Literature']
 	objective = objective.each do |objective|
 	  Objective.create(
 			user: users.sample,
 			goal: goals.sample,
 			description: Faker::Hacker.say_something_smart,
 			date: Faker::Date.between(5.days.ago, Date.today),
 			length: Faker::Number.between(30, 90),
 			title: objective
  		)
  	end

	checkin = 40.times do Checkin.create!(
		user: users.sample,
		remarks: Faker::Company.bs, 
		mood: Faker::Number.between(0, 6),
		sober: true,
		need_support: true,
		created_at: Faker::Time.between(10.days.ago, Time.now, :all)
		)
	end

	friendables = 15.times do Friendable.create!(
		to_id: users.sample.id, 
		from_id: users.sample.id, 
		accepted: true
		)
	end

	board = Board.create!(
		title: "Recovery Jobs",
		description: "Recovery friendly jobs in Nashville",
		user_id: users.sample.id, 
		rank: 0
		)
	boards = Board.all

	posts = Post.create!(
		title: "Panera Bread Cashier",
		content: "Panera on 21st is hiring part time positions at $10/hr",
		board_id: board.id,
		user_id: users.sample.id
		)

	friend_requests = 20.times do Friendable.create!(
		to_id: 1, 
		from_id: users.sample.id, 
		accepted: false
		)
	end

	 votes = 20.times do Vote.create!(
		board: boards.sample,
		user: users.sample,
		value: 1
		)
	end

	events = 50.times do Event.create!(
		name: Faker::Company.bs, 
		user_id: users.sample.id
		)
	end

	groups = 5.times do Group.create!(
		name: Faker::Company.name, 
		description: Faker::Company.bs 
		)
end

	groups = Group.all 

	groupables = 10.times do Groupable.create!(
		user_id: users.sample.id, 
		group_id: groups.sample.id 
		)
end
	puts "#{Objective.count} Objectives in database"
	puts "#{Goal.count} goals in database"
	puts "#{User.count} users in database"
	puts "#{Checkin.count} checkins in database"
	puts "#{Friendable.count} friend records added"
	puts "#{Board.count} boards in database"
	puts "#{Post.count} posts in database"
	puts "#{Friendable.where(to_id: 1).count} friend requests made for user 1"
	puts "#{Event.count} events in database"
	puts "#{Occurrence.count} occurrences of events"
	puts "#{Group.count} groups total"
	puts "#{Groupable.count} groupables total"

