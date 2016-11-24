# == Schema Information
#
# Table name: workout_types
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class WorkoutType < ApplicationRecord
  has_many :workouts
end
