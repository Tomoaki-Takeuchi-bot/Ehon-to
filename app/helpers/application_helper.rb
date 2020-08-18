module ApplicationHelper
  def alert_name(key)
    {
      'notice' => 'info',
      'alert' => 'danger'
    }.with_indifferent_access[key] || key
  end

  def heart_icon(book)
    suffix = book.has_favorites?(current_user) ? 's' : 'r'
    content_tag :i, '', class: "fa#{suffix} fa-heart"
  end

  def avator_tag(resource)
    img_tag(resource, image: 'no_avatar.jpg', class: 'avator')
  end

  def img_tag(resource, **opts)
    if resource.image?
      image_tag(resource.image.thumb.url, class: opts[:class])
    else
      image_pack_tag(opts[:image] || 'no_image.png', class: opts[:class])
    end
  end

  def follow_button(user)
    label, key = current_user.following?(user) ? ["Unfollow", "secondary"] : ["Follow", "primary"]
    link_to(label, user_follow_path(@user), method: :post, remote: true, class: "btn btn-#{key} btn-sm")
  end
end
