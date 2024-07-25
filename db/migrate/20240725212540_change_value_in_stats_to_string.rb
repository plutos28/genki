class ChangeValueInStatsToString < ActiveRecord::Migration[7.1]
  def change
    change_column :stats, :value, :string
  end
end
