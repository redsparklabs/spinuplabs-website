class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :recent_posts
  helper_method :set_metadata

  def recent_posts
    @recent_posts = Post.order('post_date DESC').limit(10)
    @budgets = ['$10k-25k','$25k-50k','$50k-100k','$100k-250k','$250k+']
  end

  def set_metadata
    if @post.meta_title?
      @page_title = @post.meta_title
    elsif !@page_title
      @page_title = "Full Service Web Development"
    end
  end
      

  protected
    def authenticate
      authenticate_or_request_with_http_basic do |username, password|
        username == USER_ID && password == PASSWORD
      end
    end
end
