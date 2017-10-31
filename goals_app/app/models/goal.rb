class Goal < ApplicationRecord
  validates :user_id, :goal, presence: true

  belongs_to :user
end
