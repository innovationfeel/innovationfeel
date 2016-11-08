module ApplicationHelper

  def meta_post_image_url(post)
    host = root_url[0..root_url.length - 2]
    "#{host}#{post.images.first.url}"
  end
end
