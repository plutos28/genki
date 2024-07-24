class PagesController < ApplicationController
  skip_before_action :authenticate
  skip_before_action :set_current_request_details

  def home
  end
end
