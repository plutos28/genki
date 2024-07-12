class WorkoutsController < ApplicationController
  def index
    @workouts = Workout.where(user_id: Current.user.id)
  end

  def new
    @workout_plan = WorkoutPlan.new
    @stats = Stat.where(user_id: Current.user.id)
    @latest_weight = @stats.where(name: 'weight').order(created_at: :desc).first
    @latest_height = @stats.where(name: 'height').order(created_at: :desc).first
    @latest_age = @stats.where(name: 'age').order(created_at: :desc).first
    @latest_bodyfat = @stats.where(name: 'bodyfat').order(created_at: :desc).first
  end

  def show
    @workout = Workout.find(params[:id])
    @exercises_completed = @workout.exercises.where(status: 'complete').count
  end

  def destroy
    @workout = Workout.find(params[:id])
    @workout.destroy
    redirect_to workouts_url, notice: 'Workout was successfully destroyed.'
  end


  def create
    sleep(10)
    @workout_plan = WorkoutPlan.new(workout_plan_params)
    @workout_plan.user_id = Current.user.id

    @exercises = [
      { name: 'Push-Up', reps: 10, sets: 3, status: 'pending', weight: nil },
      { name: 'Squat', reps: 15, sets: 3, status: 'pending', weight: 50 },   # Example weight
      { name: 'Plank', reps: 1, sets: 3, status: 'pending', weight: nil },
      { name: 'Bicep Curl', reps: 12, sets: 3, status: 'pending', weight: 15 }, # Example weight
      { name: 'Tricep Dip', reps: 12, sets: 3, status: 'pending', weight: 20 }, # Example weight
      { name: 'Lunge', reps: 12, sets: 3, status: 'pending', weight: 25 },     # Example weight
      { name: 'Crunch', reps: 15, sets: 3, status: 'pending', weight: nil },
      { name: 'Deadlift', reps: 10, sets: 3, status: 'pending', weight: 60 }   # Example weight
    ].freeze


    respond_to do |format|
      if @workout_plan.save
        

        @workout = Workout.create(user_id: Current.user.id, status: 'pending')
        selected_exercises = @exercises.sample(5)

          # Create exercises for the workout
        selected_exercises.each do |exercise|
          @workout.exercises.create(exercise)
        end

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
