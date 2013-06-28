class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body
      t.string :meta_title
      t.text :meta_description

      t.timestamps
    end
  end
end
