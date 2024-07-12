class StatsController < ApplicationController
  def index
    @stats = Stat.where(user_id: Current.user.id)
    @latest_weight = @stats.where(name: 'weight').order(created_at: :desc).first
    @latest_height = @stats.where(name: 'height').order(created_at: :desc).first
    @latest_age = @stats.where(name: 'age').order(created_at: :desc).first
    @latest_bodyfat = @stats.where(name: 'bodyfat').order(created_at: :desc).first
    # @latest_gender = @stats.where(name: 'gender').order(created_at: :desc).first
    @stat = Stat.new
  end

  def new

  end

  def statsdata
    @weight_stats = Stat.where(user_id: Current.user.id, name: 'weight').pluck(:value, :created_at).map { |value, created_at| { value: value.to_f, date: created_at } }
    @bodyfat_stats = Stat.where(user_id: Current.user.id).where(name: 'bodyfat').pluck(:value, :created_at).map { |value, created_at| { value: value.to_f, date: created_at } }
    render json: {weight: @weight_stats, bodyfat: @bodyfat_stats}
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
