class WorkoutsController < ApplicationController
  def index
    @workout_plans = WorkoutPlan.all
    @latest_workout_plan = @workout_plans.find(2)
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
        @prompt = <<-PROMPT
        Create a workout plan(week 1) only in plaintext format based on the following user data Please provide a detailed weekly workout plan including exercises each day(use day 1-7 instead of monday-sunday). DON'T include user_data in the response, just exercises. DON't format json, just single line PROMPT:
        - Weight: #{@workout_plan[:weight]} kg
        - Height: #{@workout_plan[:height]} cm
        - Age: #{@workout_plan[:age]} years
        - Body Fat: #{@workout_plan[:bodyfat]}%
        - Lifestyle: #{@workout_plan[:lifestyle]}
        - Workout Frequency: #{@workout_plan[:frequency]} days per week
        - Volume: #{@workout_plan[:volume]}
        - Duration: #{@workout_plan[:duration]} minutes per session
        - Intensity: #{@workout_plan[:intensity]}
        - Goal: #{@workout_plan[:goal]}
        - Type of Training: #{@workout_plan[:type_of_training]}
        PROMPT

        req = { prompt: @prompt, name: "victor" }
        GenerateWorkoutPlanJob.perform_later(req, Current.user.id)
        format.html { redirect_to workouts_url, notice: "Workout plan has been successfully saved. Wait for Plan to be generated."}
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
