class CreateWorkouts < ActiveRecord::Migration
  def change
    create_table :workouts do |t|
      t.string :name
      t.date :date, null: false

      t.integer :feeling
      t.text :notes
      t.integer :level_1_duration, default: 0
      t.integer :level_2_duration, default: 0
      t.integer :level_3_duration, default: 0
      t.integer :level_4_duration, default: 0
      t.integer :level_5_duration, default: 0
      t.integer :strength_duration, default: 0

      t.integer :user_id, null: false

      t.timestamps null: false
    end
  end
end
