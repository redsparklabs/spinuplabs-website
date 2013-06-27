class AddColumnsToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :post_date, :datetime
    add_column :posts, :author, :string
  end
end
