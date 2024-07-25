class Workout < ApplicationRecord
  belongs_to :user
  has_many :exercises, dependent: :destroy

  after_create_commit -> { broadcast_append_to "workouts", partial: "workouts/workout", locals: { workout: self }, target: "workouts" }

end
