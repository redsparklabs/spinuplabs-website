class Contact < ActiveRecord::Base
  attr_accessible :budget, :email, :message, :name, :phone, :subject

  validates_presence_of :name, :email, :phone, :budget, :message
end
