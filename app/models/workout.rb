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

class Workout < ApplicationRecord
  belongs_to :user
  belongs_to :workout_type

  validates_presence_of :name, :date, :feeling, :user, :workout_type
  validate :workout_has_duration

  def duration
    level_1_duration + level_2_duration + level_3_duration + level_4_duration +
      level_5_duration + strength_duration
  end

  # offset is how many of the range_type do you want to go back.
  # range_type is either 'weekly' or 'monthly' (per_page)
  # count is how many weeks or months at a time (number_of_pages)
  # # => offset: 0, range_type: 'weekly', count: 1, would mean today to 7 days ago
  # # => offset: 1, range_type: 'weekly', count: 2, would mean 7 days ago till 21 days ago
  # # => offset: 2, range_type: 'monthly,' count: 1, would mean 60 - 90 days ago
  scope :paginate_by_date, (lambda do |offset, range_type, count|
    raise 'Unknown range_type for behavior_paginator' unless %w(weekly monthly).include?(range_type.downcase)
    begin_date, end_date = paginate_day_selector(offset, range_type, count)
    where('date BETWEEN ? AND ?', begin_date, end_date)
  end)

  private

  def self.paginate_day_selector(offset, range_type, count)
    raise 'Unknown range_type for behavior_paginator' unless %w(weekly monthly).include?(range_type.downcase)
    case range_type
    when 'weekly'
      end_date = Date.current.end_of_week - offset.weeks
      begin_date = end_date - count.weeks + 1.day
    when 'monthly'
      end_date = Date.current.end_of_week - offset.months
      begin_date = end_date - count.months + 1.day
    end

    return begin_date, end_date
  end

  def workout_has_duration
    if level_1_duration == 0 && level_2_duration == 0 &&
      level_3_duration == 0 && level_4_duration == 0 &&
      level_5_duration == 0 && strength_duration == 0
      errors.add(:duration, 'Duration cannot be blank')
    end
  end
end
