class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :body
      t.string :meta_title
      t.string :meta_description

      t.timestamps
    end
  end
end
