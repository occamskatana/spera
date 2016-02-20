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
	

	goals = 10.times do Goal.create(
		title: Faker::Hipster.sentence,
		description: Faker::Hacker.say_something_smart
		)
	end

	goals = Goal.all 

	objective = 100.times do Objective.create(
		user: users.sample,
		goal: goals.sample,
		description: Faker::Hacker.say_something_smart,
		date: Faker::Date.between(5.days.ago, Date.today)
		)
	end

	checkin = 40.times do Checkin.create!(
		user: users.sample,
		remarks: Faker::Hipster.sentence, 
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
	puts "#{Objective.count} Objectives in database"
	puts "#{Goal.count} goals in database"
	puts "#{User.count} users in database"
	puts "#{Checkin.count} checkins in database"
	puts "#{Friendable.count} friend records added"

