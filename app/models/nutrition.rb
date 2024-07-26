class Nutrition < ApplicationRecord
  belongs_to :user
  belongs_to :nutrition_plan

  after_create_commit -> { broadcast_append_to "nutritions", partial: "nutrition/nutrition", locals: { nutrition: self }, target: "nutritions" }

  # Ensure only one active nutrition goal per user
  validate :only_one_active_goal, if: :activate?

  def only_one_active_goal
    if user.nutritions.where(activate: true).exists?
      errors.add(:activate, 'You can only have one active nutritional goal at a time.')
    end
  end
end
