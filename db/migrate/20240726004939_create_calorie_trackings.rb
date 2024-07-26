class CreateCalorieTrackings < ActiveRecord::Migration[7.1]
  def change
    create_table :calorie_trackings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :nutrition_plan, null: false, foreign_key: true
      t.references :nutrition, null: false, foreign_key: true
      t.integer :calories
      t.float :protein
      t.float :fat
      t.float :carbs

      t.timestamps
    end
  end
end
