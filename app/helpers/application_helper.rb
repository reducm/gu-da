# encoding: UTF-8
module ApplicationHelper
  def logout_path
    "/blog"
  end

  def blog_root_path
    root_path+"blog"
  end

  def markdown(str)
    options = { autolink:true, fenced_code_blocks:true, no_intra_emphasis:true }
    m = Redcarpet::Markdown.new(JASRender,options)
    sanitize m.render(str)
  end

  class JASRender < Redcarpet::Render::HTML
    def initialize(extensions={})
      super(extensions.merge(:xhtml => true, 
                             :no_styles => true, 
                             :filter_html => true, 
                             :hard_wrap => true))
    end

    def block_code(code, language)
      language = 'text' if language.blank?
      begin
        Pygments.highlight(code, lexer:language, formatter:'html', options:{encoding:'utf-8'})
      rescue
        Pygments.highlight(code, lexer:'text', formatter:'html', options:{encoding:'utf-8'})
      end
    end
  end
end
