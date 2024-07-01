class AddUserIdToNutritionPlans < ActiveRecord::Migration[7.1]
  def change
    add_reference :nutrition_plans, :user, null: false, foreign_key: true
  end
end
