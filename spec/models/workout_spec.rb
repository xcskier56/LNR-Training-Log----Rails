# == Schema Information
#
# Table name: workouts
#
#  id                :integer          not null, primary key
#  name              :string
#  date              :date             not null
#  feeling           :integer
#  notes             :text
#  level_1_duration  :integer          default(0)
#  level_2_duration  :integer          default(0)
#  level_3_duration  :integer          default(0)
#  level_4_duration  :integer          default(0)
#  level_5_duration  :integer          default(0)
#  strength_duration :integer          default(0)
#  user_id           :integer          not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  workout_type_id   :integer          not null
#

require 'rails_helper'

RSpec.describe Workout, type: :model do
  describe 'duration validations' do
    let(:workout_type) { WorkoutType.first }
    let(:user) { User.new }
    let(:workout_attrs) do
      {
        name: workout_type.name, workout_type: workout_type,
        date: Date.current, feeling: 4, user: user
      }
    end
    let(:workout) { Workout.new(workout_attrs) }

    it 'validates workout is invalid' do
      expect(workout.valid?).to eq false
      expect(workout.errors.keys).to eq [:duration]
    end
  end
end
