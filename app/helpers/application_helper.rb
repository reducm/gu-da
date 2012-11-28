# encoding: UTF-8
require "redcarpet"
module ApplicationHelper
  def logout_path
    "/blog"
  end

  def blog_root_path
    root_path+"blog"
  end

  def markdown(str, options = {})
    #options[:hard_wrap] ||= false
    #options[:class] ||= ''
    #assembler = Redcarpet::Render::HTML.new(:hard_wrap => options[:hard_wrap]) # auto <br> in <p>

    #renderer = Redcarpet::Markdown.new(assembler, {
      #:autolink => true,
      #:fenced_code_blocks => true
    #})
    raw(MarkdownTopicConverter.format(str))
  end
end
