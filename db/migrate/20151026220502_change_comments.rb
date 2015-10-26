class ChangeComments < ActiveRecord::Migration
  def change
    add_column :comments, :author_id, :integer, index: true, null: false
  end
end
