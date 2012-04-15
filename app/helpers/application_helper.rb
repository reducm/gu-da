module ApplicationHelper
  def logout_path
    "/blog"
  end

  def blog_root_path
    root_path+"blog"
  end

  def markdown(str)
    options = { autolink:true, hard_wrap:true, fenced_code_blocks:true }
#    m = Redcarpet::Markdown.new(Redcarpet::Render::HTML,options)

    m = Redcarpet::Markdown.new(JASRender,options)
    sanitize m.render(str)
  end

  class JASRender < Redcarpet::Render::HTML
    def block_code(code, language)
      language = 'text' if language.blank?
      begin
        Pygments.highlight(code, lexer:language, formatter:'html', encoding:'utf-8')
      rescue
        Pygments.highlight(code, lexer:'text', formatter:'html', encoding:'utf-8')
      end
    end
  end
end
