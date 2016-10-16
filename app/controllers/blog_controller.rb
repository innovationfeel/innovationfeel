class BlogController < ApplicationController
  def index
    @posts = Post.order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
    @post = Post.friendly.find(params[:post_slug])
  end
end
