class PagesController < HighVoltage::PagesController
  #before_filter :authenticate
  #layout :layout_for_page

    layout 'default'

    def home
        @posts = latest_from_blog
        $title = "Home"
    end

    def about
        @posts = latest_from_blog
        $title = "About Us"
    end

    def work
        $title = "Past Work"
    end

    def team
        $title = "The Team"
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
