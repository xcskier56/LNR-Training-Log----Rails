class CreateWorkoutTypes < ActiveRecord::Migration[5.0]
  def change
    add_column :workouts, :workout_type_id, :integer, null: false
    create_table :workout_types do |t|
      t.string :name, null: false
      t.timestamps
    end
  end
end
