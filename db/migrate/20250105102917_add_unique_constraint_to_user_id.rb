class AddUniqueConstraintToUserId < ActiveRecord::Migration[7.2]
  def up
    # Add a unique index to the user_id column to enforce uniqueness
    remove_index :creators, :user_id
    add_index :creators, :user_id, unique: true
  end

  def down
    remove_index :creators, :user_id, unique: true
    add_index :creators, :user_id
  end
end
