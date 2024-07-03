class NutritionController < ApplicationController
  def index
    @nutritions = Nutrition.where(user_id: Current.user.id)
  end

  def new
    @nutrition_plan = NutritionPlan.new
    @stats = Stat.where(user_id: Current.user.id)
    @latest_weight = @stats.where(name: 'weight').order(created_at: :desc).first
    @latest_height = @stats.where(name: 'height').order(created_at: :desc).first
    @latest_age = @stats.where(name: 'age').order(created_at: :desc).first
    @latest_bodyfat = @stats.where(name: 'bodyfat').order(created_at: :desc).first
  end

  def show
    @nutrition = Nutrition.find(params[:id])
  end

  def create
    @nutrition_plan = NutritionPlan.new(nutrition_plan_params)
    @nutrition_plan.user_id = Current.user.id

    respond_to do |format|
      if @nutrition_plan.save
        @prompt = <<-PROMPT
        Create a nutrition plan(week 1) only in plaintext format based on the following user data Please provide a detailed weekly nutrition plan including exercises each day(use day 1-7 instead of monday-sunday). DON'T include user_data in the response, just nutrition. DON't format json, just single line PROMPT:
        - Weight: #{@nutrition_plan[:weight]} kg
        - Height: #{@nutrition_plan[:height]} cm
        - Age: #{@nutrition_plan[:age]} years
        - Body Fat: #{@nutrition_plan[:bodyfat]}%
        - Lifestyle: #{@nutrition_plan[:lifestyle]}
        - protein: #{@nutrition_plan[:protein]}
        - fat: #{@nutrition_plan[:fat]}
        - carb: #{@nutrition_plan[:carb]}
        - Goal: #{@nutrition_plan[:goal]}
        PROMPT

        req = { prompt: @prompt }
        GenerateNutritionPlanJob.perform_later(req, Current.user.id)
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
