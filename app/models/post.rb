class Post < ActiveRecord::Base
  attr_accessible :body, :meta_description, :meta_title, :title, :post_date, :author, :slug, :intro

  validates_presence_of :body, :title, :post_date, :slug, :author
end
