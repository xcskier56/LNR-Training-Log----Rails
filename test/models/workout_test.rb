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

require 'test_helper'

class WorkoutTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
