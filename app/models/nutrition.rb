class Nutrition < ApplicationRecord
  belongs_to :user

  after_create_commit -> { broadcast_append_to "nutritions", partial: "nutrition/nutrition", locals: { nutrition: self }, target: "nutritions" }

end
