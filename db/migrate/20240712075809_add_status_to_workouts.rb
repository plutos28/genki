class AddStatusToWorkouts < ActiveRecord::Migration[7.1]
  def change
    add_column :workouts, :status, :string
  end
end
