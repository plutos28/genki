class ExercisesController < ApplicationController

	def update_status
    @exercise = Exercise.find(params[:id])
    new_status = params[:status] == 'pending' ? 'complete' : 'pending'

    @exercise.update(status: new_status)
    head :ok  # Return a 200 OK response for AJAX requests

  end

end
