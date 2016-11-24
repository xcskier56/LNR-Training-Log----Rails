# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

workout_types = [
  'Rollerski Classic',
  'Rollerski Skate',
  'Double Pole',
  'Ski Skate',
  'Ski Classic',
  'Run',
  'Road Bike',
  'Mountain Bike',
  'Core',
  'Bounding',
  'Strength',
  'Yoga',
  'Soccer',
  'Legs only skate',
  'Legs only classic'
].each do |name|
  wt = WorkoutType.find_by name: name
  next if !wt.nil?

  WorkoutType.create(name: name)
end
