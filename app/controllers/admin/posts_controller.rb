module Admin
  class PostsController < AdminController
    before_action :find_post, only: [:edit, :update, :destroy]

    def new
      @post = Post.new
    end

    def create
      @post = current_user.posts.new(post_params)
      if @post.save
        redirect_to blog_path
      else
        render :edit
      end
    end

    def edit
    end

    def update
      if @post.update(post_params)
        redirect_to blog_show_path(@post)
      else
        render :edit
      end
    end

    def destroy
      @post.destroy
    end

  private

    def find_post
      @post = Post.friendly.find(params[:post_slug])
    end

    def post_params
      params.require(:post).permit(:title, :body, {images: []})
    end
  end
end
