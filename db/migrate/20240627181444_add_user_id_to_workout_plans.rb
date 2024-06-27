class AddUserIdToWorkoutPlans < ActiveRecord::Migration[7.1]
  def change
    add_reference :workout_plans, :user, null: false, foreign_key: true
  end
end
