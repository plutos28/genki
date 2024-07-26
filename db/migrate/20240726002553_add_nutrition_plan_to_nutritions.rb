class AddNutritionPlanToNutritions < ActiveRecord::Migration[7.1]
  def change
    add_reference :nutritions, :nutrition_plan, foreign_key: true
  end
end
