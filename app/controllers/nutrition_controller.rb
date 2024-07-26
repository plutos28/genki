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

  def activate
    # Deactivate all other nutrition goals for the user
    Current.user.nutritions.update_all(activate: false)

    @nutrition = Nutrition.find(params[:id])

    # Activate the selected nutrition goal
    if @nutrition.update(activate: true)
      redirect_to nutrition_path, notice: 'Nutrition goal was successfully activated.'
    else
      redirect_to nutrition_path, alert: 'Failed to activate the nutrition goal.'
    end
  end

  def destroy
    @nutrition = Nutrition.find(params[:id])
    @nutrition.destroy
    redirect_to nutrition_url, notice: 'Nutrition plan was successfully destroyed.'
  end

  def show
    @nutrition = Nutrition.find(params[:id])

    @stats = Stat.where(user_id: Current.user.id)
    @latest_weight = @stats.where(name: 'weight').order(created_at: :desc).first
    @latest_height = @stats.where(name: 'height').order(created_at: :desc).first
    @latest_age = @stats.where(name: 'age').order(created_at: :desc).first
    @latest_bodyfat = @stats.where(name: 'bodyfat').order(created_at: :desc).first

    if @latest_weight && @latest_height && @latest_age
      weight = @latest_weight.value.to_f
      height = @latest_height.value.to_f
      age = @latest_age.value.to_i

      gender = "male"

      # Calculate BMR
      bmr = if gender == 'male'
              10 * weight + 6.25 * height - 5 * age + 5
            else
              10 * weight + 6.25 * height - 5 * age - 161
            end

      # Adjust BMR based on activity level (example: moderately active)
      activity_level = params[:activity_level] || 'moderate' # Default to 'moderate'
      activity_factor = case activity_level
                         when 'sedentary' then 1.2
                         when 'lightly_active' then 1.375
                         when 'moderately_active' then 1.55
                         when 'very_active' then 1.725
                         when 'super_active' then 1.9
                         else 1.55 # Default to 'moderately_active'
                         end

      @tdee = bmr * activity_factor
    else
      @tdee = nil
    end
  end

  def create
    @nutrition_plan = NutritionPlan.new(nutrition_plan_params)
    @nutrition_plan.user_id = Current.user.id

    respond_to do |format|
      if @nutrition_plan.save
        @prompt = <<-PROMPT
        Create a simple nutrition plan(week 1) only in plaintext format based #{@nutrition_plan.goal}. keep the response very short and without details PROMPT. :
        PROMPT

        req = { prompt: @prompt }
        GenerateNutritionPlanJob.perform_later(req, Current.user.id, @nutrition_plan.id)
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
