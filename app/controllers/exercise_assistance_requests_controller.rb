class ExerciseAssistanceRequestsController < ApplicationController
  def index
    @exercise_assistance_request = Current.user.exercise_assistance_requests.new
  end

  def new
    @exercise_assistance_request = Current.user.exercise_assistance_requests.new
  end

  def create
    @exercise_assistance_request = Current.user.exercise_assistance_requests.new(exercise_assistance_request_params)

    if @exercise_assistance_request.save
      redirect_to exercise_assistance_requests_path, notice: 'Assistance request submitted successfully.'
    else
      render :new
    end
  end

  private

  def exercise_assistance_request_params
    params.require(:exercise_assistance_request).permit(:exercise, :issue, :extra_info)
  end

end
