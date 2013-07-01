class PagesController < ApplicationController
  require 'kramdown'
  def index
    @page_title = "Home -> Full Service Web Consulting Company"
  end

  def about
    @page_title = "About Us -> Who we are and why we do what we do"
  end

  def contact
    @page_title = "Contact Us -> How can we help you?"
    @contact = Contact.new
  end

  def our_process
    @page_title = "Process -> Building blocks for a successful startup!"
  end

  def blog
    @posts = Post.order('post_date DESC').page params[:page]
    @page_title = "Blog -> Our opinions about hacking and hustling for Startups!"
    #@post_pages, @posts = paginate(:posts, :order => 'post_date DESC', :per_page => 2)
  end
end
