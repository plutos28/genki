class WorkoutsController < ApplicationController
  def index
    @workout_plans = WorkoutPlan.all
    @latest_workout_plan = @workout_plans.find(2)

    @prompt = <<-PROMPT
      Create a weekly workout plan based on the following user data:
      - Weight: #{@latest_workout_plan[:weight]} kg
      - Height: #{@latest_workout_plan[:height]} cm
      - Age: #{@latest_workout_plan[:age]} years
      - Body Fat: #{@latest_workout_plan[:bodyfat]}%
      - Lifestyle: #{@latest_workout_plan[:lifestyle]}
      - Workout Frequency: #{@latest_workout_plan[:workout_frequency]} days per week
      - Volume: #{@latest_workout_plan[:volume]}
      - Duration: #{@latest_workout_plan[:duration]} minutes per session
      - Intensity: #{@latest_workout_plan[:intensity]}
      - Goal: #{@latest_workout_plan[:goal]}
      - Type of Training: #{@latest_workout_plan[:type_of_training]}

      Please provide a detailed weekly workout plan including exercises, sets, and reps for each day.
      PROMPT

      # uri = URI("http://localhost:11434/api/generate")
      # http = Net::HTTP.new(uri.host, uri.port)
      # request = Net::HTTP::Post.new(uri, "Content-Type" => "application/json")
      # request.body = {
      #   model: "phi3",
      #   prompt: @prompt,
      #   stream: false
      # }.to_json

      # @response = http.request(request)
      # @response = JSON.parse(@response.body)

      # GenerateWorkoutPlanJob.perform_later(@response)

  end

  def context(prompt)
    "[INST]#{prompt}[/INST]"
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
