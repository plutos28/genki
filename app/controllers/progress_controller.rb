class ProgressController < ApplicationController
  def index
    # for calories
    @tdee = calculate_tdee
    @current_nutrition = Nutrition.where(activate: true).order(created_at: :desc).first
    @current_nutrition_plan = NutritionPlan.find(@current_nutrition.nutrition_plan_id)
    @daily_calorie_goal = case @current_nutrition_plan.goal.downcase
      when 'lose weight'
        @tdee - 500 # Caloric deficit for weight loss
      when 'gain weight'
        @tdee + 500 # Caloric surplus for weight gain
      when 'build muscle'
        @tdee + 250 # Caloric surplus for muscle building
      when 'maintain weight'
        @tdee # No change for maintenance
      else
        @tdee # Default to no change if goal is unknown
      end
  end

  def calculate_tdee
    @stats = Stat.where(user_id: Current.user.id)
    latest_weight = @stats.where(name: 'weight').order(created_at: :desc).first.value.to_f
    latest_height = @stats.where(name: 'height').order(created_at: :desc).first.value.to_f
    latest_age = @stats.where(name: 'age').order(created_at: :desc).first.value.to_i
    latest_bodyfat = @stats.where(name: 'bodyfat').order(created_at: :desc).first.value.to_f
    latest_gender = @stats.where(name: 'gender').order(created_at: :desc).first.value
    latest_lifestyle = @stats.where(name: 'lifestyle').order(created_at: :desc).first.value

    bmr = if latest_gender.downcase == 'male'
      88.362 + (13.397 * latest_weight) + (4.799 * latest_height) - (5.677 * latest_age)
    else
      447.593 + (9.247 * latest_weight) + (3.098 * latest_height) - (4.330 * latest_age)
    end

    tdee = case latest_lifestyle.downcase
        when 'sedentary'
          bmr * 1.2
        when 'light exercise'
          bmr * 1.375
        when 'moderate exercise'
          bmr * 1.55
        when 'heavy exercise'
          bmr * 1.725
        when 'elite athlete'
          bmr * 1.9
        else
          bmr * 1.2 # Default to sedentary if unknown
        end

    tdee.to_i
  end

  def workout

  end
end
