class PagesController < ApplicationController
  require 'kramdown'
  def index
  end

  def about
  end

  def contact
    @contact = Contact.new
  end

  def our_process
  end

  def blog
    @posts = Post.order('post_date DESC').page params[:page]
    #@post_pages, @posts = paginate(:posts, :order => 'post_date DESC', :per_page => 2)
  end
end
