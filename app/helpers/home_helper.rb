module HomeHelper
  def active_in(path)
    "active" if current_page? path
  end

  def render_unless_empty(items)
    items.length > 0 ?
      render(items)
    : (<<"no-items"
<p class="no-items">
  投稿はまだありません。
  <br>
  <a href="/drafts/new">Qiita全体の投稿</a>を見て、あなたの持っているtips、コードを投稿したり、タグやユーザーをフォローしてみましょう!
</p>
no-items
      ).html_safe
  end
end
