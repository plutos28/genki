class CalorieTracking < ApplicationRecord
  belongs_to :user
  belongs_to :nutrition_plan
  belongs_to :nutrition
end
