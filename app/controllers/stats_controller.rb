class StatsController < ApplicationController
  def index
    @stats = Stat.all
    @stat = Stat.new
  end

  def new

  end

  def create
    @stat = Stat.new(stat_params)
    @stat.user_id = Current.user.id

    respond_to do |format|
      if @stat.save
        format.html { redirect_to stats_url, notice: "Stats have been successfully saved"}
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private

  def stat_params
    params.require(:stat).permit(:name, :value, :unit)
  end
end
