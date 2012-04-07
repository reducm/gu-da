module ApplicationHelper
  def logout_path
    "/blog"
  end

  def blog_root_path
    root_path+"blog"
  end

  def markdown(str)
    m = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
    m.render(str)
  end
end
