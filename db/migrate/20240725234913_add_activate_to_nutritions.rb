class AddActivateToNutritions < ActiveRecord::Migration[7.1]
  def change
    add_column :nutritions, :activate, :boolean
  end
end
