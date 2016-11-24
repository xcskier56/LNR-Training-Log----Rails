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

class WorkoutSerializer < ActiveModel::Serializer
  attributes :id, :name, :date, :feeling, :notes,
    :level_1_duration, :level_2_duration, :level_3_duration,
    :level_4_duration, :level_5_duration, :strength_duration,
    :user_id, :workout_type_id, :created_at, :updated_at
end
