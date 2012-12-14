atom_feed do |feed|
  feed.title @title
  feed.updated @updated

  @articles.each do |item|
    next if item.updated_at.blank?

    feed.entry( item  ) do |entry|
      entry.url article_url(item)
      entry.title item.title
      entry.content item.markdown_content, :type => 'html'

      entry.updated(item.updated_at.strftime("%Y-%m-%dT%H:%M:%SZ")) 

      entry.author do |author|
        author.name @current_user.name
      end
    end
  end
end
