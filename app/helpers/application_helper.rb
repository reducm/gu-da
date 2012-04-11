module ApplicationHelper
  def logout_path
    "/blog"
  end

  def blog_root_path
    root_path+"blog"
  end

  def markdown(str)
    options = { autolink:true, hard_wrap:true }
    m = Redcarpet::Markdown.new(Redcarpet::Render::HTML,options)
    sanitize m.render(str)
  end
end
