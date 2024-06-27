class CreateStats < ActiveRecord::Migration[7.1]
  def change
    create_table :stats do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.decimal :value
      t.string :unit

      t.timestamps
    end
  end
end
