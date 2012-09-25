class DropTableLikes < ActiveRecord::Migration
  def change
    drop_table :likes
  end
end
