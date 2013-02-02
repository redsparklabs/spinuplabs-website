class PagesController < HighVoltage::PagesController
  #before_filter :authenticate
  #layout :layout_for_page

    layout 'spinup'

    def home
        @posts = latest_from_blog
    end

    def spinup
        @posts = latest_from_blog
    end

    protected

    def layout_for_page
        case params[:id]
            when 'home'
                'application'
            else
                'application'
            end
        end

    def latest_from_blog
        Post.all.first(2)
    end
end
