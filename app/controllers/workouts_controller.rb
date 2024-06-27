class WorkoutsController < ApplicationController
  def index
    
  end

  def new
    @workout_plan = WorkoutPlan.new
    @stats = Stat.where(user_id: Current.user.id)
    @latest_weight = @stats.where(name: 'weight').order(created_at: :desc).first
    @latest_height = @stats.where(name: 'height').order(created_at: :desc).first
    @latest_age = @stats.where(name: 'age').order(created_at: :desc).first
    @latest_bodyfat = @stats.where(name: 'bodyfat').order(created_at: :desc).first
  end

  def create
    @workout_plan = WorkoutPlan.new(workout_plan_params)
    @workout_plan.user_id = Current.user.id

    respond_to do |format|
      if @workout_plan.save
        format.html { redirect_to workouts_url, notice: "Workout plan have been successfully generated"}
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private 

  def workout_plan_params
    params.require(:workout_plan).permit(:weight, :height, :age, :bodyfat, :lifestyle, :frequency, :volume, :duration, :intensity, :goal, :type_of_training)
  end
end
