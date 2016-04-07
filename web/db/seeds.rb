# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

	user_images = ['https://s3.amazonaws.com/spera-data/asian-girl.jpeg',
								 'https://s3.amazonaws.com/spera-data/black-guy-1.jpeg',
								 'https://s3.amazonaws.com/spera-data/white-guy-1.jpeg',
								 'https://s3.amazonaws.com/spera-data/white-guy-2.jpeg' 
								]

	users = 10.times do User.create!(
		username: Faker::Internet.user_name,
		first_name: Faker::Name.first_name,
		last_name: Faker::Name.last_name,
		email: Faker::Internet.email,
		password: 'helloworld'
	#	avatar: user_images.sample
		)
	end

	users = User.all
	

	goal_info = [ 
						{title: 'Stay Sober', description: "I want to stay sober and spiritually fit. I had a great month at Michael's House and feel the best I have in a long time and now I'm going home stay on track."},
						{title: 'Get a Job', description: 'I want to land a great job I can be proud of. I am beginning the process building my resume and looking for places back home.'},
						{title: 'Get in Shape', description: 'Help me get fit!'},
						{title: 'Buy a House', description: 'Help me save up to buy a place of my own'} 
					]

 	goals = goal_info.each do |goal|
 	  Goal.create(
 			title: goal[:title],
 			description: goal[:description]
  		)
  	end
  
  	goals = Goal.all

	goals = Goal.all 

	suggested_objectives = ['Call Sponsor', 'Morning Routine', 'Evening Routine', 'Meditation', 
 		           						'Therapy', 'Stepwork', 'Exercise', 'Meds', 'Relaxation', 'Read Literature', 'Create my own!']
  suggested_objectives = suggested_objectives.each do |obj|
  	SuggestedObjective.create!(title: obj)
  end

	objective = [ {title: 'Call Sponsor', description: 'Keep up to date with my sponsor'},
								{title: 'Morning Routine', description: 'Start the day with a spiritual reflection'},
								{title: 'Evening Routine', description: 'Pray before I sleep at night'},
								{title: 'Meditation', description: 'Take a few minutes to ground myself in mindfulness'},
								{title: 'Therapy', description: 'Keep up with my therapist'},
								{title: 'Stepwork', description: 'Work through my 10th step!'},
								{title: 'Exercise', description: 'Running, biking, and swimming to stay fit'},
								{title: 'Meds', description: 'Take my happy meds :)'},
								{title: 'Relaxation', description: 'Take some time to relax for myself'},
								{title: 'Literature Reading', description: 'Read up on recovery!'}
							]
	 
 	objective = objective.each do |objective|
 	  Objective.create(
 			user: User.find(1,2).sample,
 			goal: goals.sample,
 			description: objective[:description],
 			date: Faker::Date.between(5.days.ago, Date.today),
 			length: Faker::Number.between(30, 90),
 			title: objective[:title],
 			recurring: 'daily',
 			times_completed: 0
  		)
  	end

  checkin_remarks = ["I'm feeling better than yesterday", 'I love myself today and thankful for all you guys', 
  									 'Struggling but staying strong... I know I can do it', 'I could really use some help today :(',
  									 "I'm so overwhelemed but know the meeting tonight will help :)"]

	checkin = 40.times do Checkin.create!(
		user: users.sample,
		remarks: checkin_remarks.sample, 
		mood: Faker::Number.between(0, 9),
		sober: [true,false].sample,
		need_support: [true,false].sample,
		created_at: Faker::Time.between(10.days.ago, Time.now, :all)
		)
	end

	friendables = users[0..5].each_with_index do |user, i|
		Friendable.create!(
			to_id: user.id + 1,
			from_id: user.id,
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

	friend_requests = 1.times do Friendable.create!(
		to_id: 1, 
		from_id: 8 ,
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
		name: Faker::Lorem.sentence,
		user_id: users.sample.id
		)
	end

	groups = [
						{name: 'Connections Bros', description: 'Connections represent'},
						{name: "Michael's House Alumni", description: "Michael's House alumni program"},
						{name: 'United Methodist Home group', description: 'Home group friends'},
						{name: 'Family', description: 'The Carters'},
						{name: '813 Besties', description: 'Recovery friends in Tampa'}
					 ]

	groups = groups.each do |group|
		Group.create!(
		name: group[:name], 
		description: group[:description]
		)
	end

	groups = Group.all 

	groupables = 15.times do Groupable.create!(
		user_id: users.sample.id, 
		group_id: groups.sample.id, 
		accepted: true
		)
	end

	group_invites = 25.times do Groupable.create!(
		user_id: users.sample.id, 
		group_id: groups.sample.id,
		accepted: false
		)
	end

	group_invites = Groupable.where(accepted: false)

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
	puts "#{group_invites.count} Group invites created"

