class Tagging < ApplicationRecord
  belongs_to :goal
  belongs_to :tag
end
