module Md2html
  class HTMLwithCoderay < Redcarpet::Render::HTML
    def block_code(code, language)
      CodeRay.scan(code, language).div
    end
  end

  def convert(md)
    @renderer ||= Redcarpet::Markdown.new(
      HTMLwithCoderay.new(filter_html: true, hard_wrap: true),
      autolink: true, fenced_code_blocks: true)
    @renderer.render(md)
  end
end
