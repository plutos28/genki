class AddResponseToExerciseAssistanceRequests < ActiveRecord::Migration[7.1]
  def change
    add_column :exercise_assistance_requests, :response, :text
  end
end
