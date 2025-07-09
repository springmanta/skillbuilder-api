class Goal < ApplicationRecord
  belongs_to :user
  belongs_to :topic

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
end
