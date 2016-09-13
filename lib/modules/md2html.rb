module Md2html
  class HTMLwithCoderay < Redcarpet::Render::HTML
    def block_code(code, language)
      CodeRay.scan(code,
        case language.to_s
        when "rb" then "ruby"
        when "yml" then "yaml"
        when "" then "md"
        else language.match(/\w+/)[0]
        end
      ).div
    end
  end

  def convert(md)
    return unless md.present?
    @renderer ||= Redcarpet::Markdown.new(
      HTMLwithCoderay.new(filter_html: true, hard_wrap: true),
      autolink: true, fenced_code_blocks: true)
    @renderer.render(md)
  end
end
