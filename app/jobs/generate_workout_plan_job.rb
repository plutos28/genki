class GenerateWorkoutPlanJob < ApplicationJob
  queue_as :default

  def perform(data)
    # Do something later
  end
end
