class Tag < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :taggings, dependent: :destroy
  has_many :goals, through: :taggings
end
