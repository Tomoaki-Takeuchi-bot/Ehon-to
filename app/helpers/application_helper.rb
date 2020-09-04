module ApplicationHelper
  def alert_name(key)
    { 'notice' => 'info', 'alert' => 'danger' }.with_indifferent_access[key] ||
      key
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
    label, key =
      if current_user.following?(user)
        %w[Unfollow secondary]
      else
        %w[Follow primary]
      end
    link_to(
      label,
      user_follow_path(@user),
      method: :post, remote: true, class: "btn btn-#{key} btn-sm"
    )
  end

  def favorites_group_by_tag(books)
    books.map(&:tag_list).flatten.uniq.map do |tag|
      # Bookに登録しているタグを抽出、flattenで再帰的に配列、重複要素を除く
      ids =
        books.tagged_with(tag).ids # タグに紐づくいいねした本を抽出、id取得
      [tag, ids] # タグとタグを登録しているidの配列
    end.sort_by { |r| r.last.size }.reverse # いいねした本の中で該当するタグの多さ順に並べ替えてる。
  end
end
