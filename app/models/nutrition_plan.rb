class NutritionPlan < ApplicationRecord
    belongs_to :user
    has_many :nutritions, dependent: :destroy
end
