class StatsController < ApplicationController
  def index
    @stats = Stat.where(user_id: Current.user.id)
    @latest_weight = @stats.where(name: 'weight').order(created_at: :desc).first
    @latest_height = @stats.where(name: 'height').order(created_at: :desc).first
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
