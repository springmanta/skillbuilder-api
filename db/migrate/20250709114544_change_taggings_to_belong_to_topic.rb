class ChangeTaggingsToBelongToTopic < ActiveRecord::Migration[8.0]
  def change
    remove_reference :taggings, :goal, foreign_key: true
    add_reference :taggings, :topic, foreign_key: true, null: false
  end
end
