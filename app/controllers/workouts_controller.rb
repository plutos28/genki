class WorkoutsController < ApplicationController
  def index
  end

  def new
    @workout_plan = WorkoutPlan.new
  end
end
