class CreateNutritionPlans < ActiveRecord::Migration[7.1]
  def change
    create_table :nutrition_plans do |t|
      t.decimal :weight
      t.decimal :height
      t.decimal :age
      t.decimal :bodyfat
      t.string :lifestyle
      t.string :protein
      t.string :fat
      t.string :carb
      t.string :goal

      t.timestamps
    end
  end
end
