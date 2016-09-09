module MarkdownHelper
  include Md2html

  def md(text)
    raw convert(text)
  end
end
