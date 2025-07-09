class Tag < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :topics, through: :taggings

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  def as_json(options = {})
    super({ only: [:id], methods: [:formatted_name] }.merge(options))
  end

  def formatted_name
    name.capitalize
  end
end
