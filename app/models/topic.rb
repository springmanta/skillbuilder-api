class Topic < ApplicationRecord
  has_many :goals, dependent: :destroy
  has_many :taggings
  has_many :tags, through: :taggings

  validates :name, presence: true, uniqueness: true
end
