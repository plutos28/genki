class CreateWorkoutPlans < ActiveRecord::Migration[7.1]
  def change
    create_table :workout_plans do |t|
      t.decimal :weight
      t.decimal :height
      t.decimal :age
      t.decimal :bodyfat
      t.string :lifestyle
      t.string :frequency
      t.string :volume
      t.integer :duration
      t.string :intensity
      t.string :goal
      t.string :type_of_training

      t.timestamps
    end
  end
end
