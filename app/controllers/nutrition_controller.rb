class NutritionController < ApplicationController
  def index
    @nutrition_plans = NutritionPlan.all
  end

  def new
    @nutrition_plan = NutritionPlan.new
    @stats = Stat.where(user_id: Current.user.id)
    @latest_weight = @stats.where(name: 'weight').order(created_at: :desc).first
    @latest_height = @stats.where(name: 'height').order(created_at: :desc).first
    @latest_age = @stats.where(name: 'age').order(created_at: :desc).first
    @latest_bodyfat = @stats.where(name: 'bodyfat').order(created_at: :desc).first
  end

  def create
    @nutrition_plan = NutritionPlan.new(nutrition_plan_params)
    @nutrition_plan.user_id = Current.user.id

    respond_to do |format|
      if @nutrition_plan.save
        format.html { redirect_to nutrition_index_url, notice: "Nutrition plan has been successfully generated"}
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private 

  def nutrition_plan_params
    params.require(:nutrition_plan).permit(:weight, :height, :age, :bodyfat, :lifestyle, :protein, :fat, :carb, :goal)
  end
end
