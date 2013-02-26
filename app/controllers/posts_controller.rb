class PostsController < ApplicationController
  #layout lambda { |controller| Postmarkdown::Config.options[:use_theme] ? 'postmarkdown' : 'application' }
  layout 'default'

  def show
    resource
    $title = @resource.title
    $keywords = @resource.keywords
    $description = @resource.description
  end

  def home
    collection
  end

  def feed
    max_age = 4.hours
    response.headers['Cache-Control'] = 'public, max-age=' + max_age.to_i.to_s
    response.headers['Expires'] = max_age.from_now.httpdate
    response.content_type = 'application/atom+xml'
    fresh_when :last_modified => Post.feed_last_modified
  end

  protected

  def resource
    @resource ||= Post.find(params[:id])
  end
  helper_method :resource

  def collection
    @collection ||= begin
      posts = Post.where(params.slice(:year, :month, :day))
      posts = Kaminari.paginate_array(posts).page(params[:page]).per(posts_per_page)
      posts
    end
  end
  helper_method :collection

  private

  def posts_per_page
    params[:count] || Postmarkdown::Config.options[:posts_per_page]
  end
end
