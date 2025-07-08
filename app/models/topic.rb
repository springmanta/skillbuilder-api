class Topic < ApplicationRecord
  has_many :goals, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
