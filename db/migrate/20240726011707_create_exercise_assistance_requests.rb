class CreateExerciseAssistanceRequests < ActiveRecord::Migration[7.1]
  def change
    create_table :exercise_assistance_requests do |t|
      t.references :user, null: false, foreign_key: true
      t.string :exercise
      t.string :issue
      t.text :extra_info

      t.timestamps
    end
  end
end
