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
      
    #from ruby-china
    def autolink(link, link_type)
      # return link
      if link_type.to_s == "email"
        link          
      else
        begin
          # 防止 C 的 autolink 出来的内容有编码错误，万一有就直接跳过转换
          # 比如这句:
          # 此版本并非线上的http://yavaeye.com的源码.
          link.match(/.+?/)
        rescue
          return link
        end
        # Fix Chinese neer the URL
        bad_text = link.to_s.match(/[^\w\d:\/\-\,\$\!\_\.=\?&#+\|\%]+/im).to_s
          link = link.to_s.gsub(bad_text, '')
        "<a href=\"#{link}\" rel=\"nofollow\" target=\"_blank\">#{link}</a>#{bad_text}"
      end
    end

  end
end
