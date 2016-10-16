module Admin
  class HomeController < AdminController
    def index
      redirect_to blog_path
    end
  end
end
