class UserComment < ApplicationRecord
  validates :user_id, :poster_id, :body, presence: true

  belongs_to :user

  belongs_to :poster,
    class_name: :User
end
