class AddWeightToExercises < ActiveRecord::Migration[7.1]
  def change
    add_column :exercises, :weight, :float
  end
end
