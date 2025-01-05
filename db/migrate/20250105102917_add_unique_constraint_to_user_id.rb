class AddUniqueConstraintToUserId < ActiveRecord::Migration[7.2]
  def up
    # Add a unique index to the user_id column to enforce uniqueness
    add_index :creators, :user_id, unique: true
  end

  def down
    # Remove the unique index from the user_id column
    remove_index :creators, :user_id
  end
end