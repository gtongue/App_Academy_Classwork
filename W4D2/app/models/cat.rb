# == Schema Information
#
# Table name: cats
#
#  id          :integer          not null, primary key
#  birth_date  :date             not null
#  color       :string           not null
#  name        :string           not null
#  sex         :string           not null
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Cat < ApplicationRecord
  validates :birth_date, :color, :name, :sex, presence: true

  COLORS = %w( red orange yellow green blue indigo purple )
  validates :color, inclusion: { in: COLORS,
    message: "Pick another color." }

  validates :sex, inclusion: { in: ['M', 'F'],
    message: "Non-binary gender support coming soon(TM)!"}

  has_many :cat_rental_requests,
    class_name: 'CatRentalRequest',
    foreign_key: :cat_id,
    primary_key: :id,
    dependent: :destroy

  def age
    (Time.now.to_date - self.birth_date).to_i/365
  end

  def self.colors
    COLORS
  end
end
