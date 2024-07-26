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
      @prompt = <<-PROMPT
        As a personal fitness coach respond to this user's issue with #{@exercise_assistance_request.exercise} #{@exercise_assistance_request.issue}. Here's more information: #{@exercise_assistance_request.extra_info} keep the response very short and without details PROMPT. :
        PROMPT

        req = { prompt: @prompt }
        ExerciseAssistanceResponseJob.perform_later(req, @exercise_assistance_request.id)
      redirect_to exercise_assistance_requests_path , notice: 'Assistance request submitted successfully.'
    else
      render :new
    end
  end

  private

  def exercise_assistance_request_params
    params.require(:exercise_assistance_request).permit(:exercise, :issue, :extra_info)
  end

end
