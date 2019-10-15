module ApplicationHelper
    require "redcarpet"
    require "coderay"

    class HTMLwithCoderay < Redcarpet::Render::HTML
      def block_code(code, language)
        language = language.split(':')[0] if language.present?
        case language.to_s
        when 'rb'
          lang = :ruby
        when 'yml'
          lang = :yaml
        when 'css'
          lang = :css
        when 'html'
          lang = :html
        when ''
          lang = :md
        else
          lang = language
        end

    end
      def initializer(code)
    
        CodeRay.scan(code, :ruby).div(:line_numbers => :table)
      end
    end

    def markdown(text)
        # html_render = Redcarpet::Render::HTML.new(
        #     filter_html: true,
        #     hard_wrap: true,
        #     link_attributes: { rel: 'nofollow', target: "_blank" }
        #     )
        html_render = HTMLwithCoderay.new(
          filter_html: true,
          hard_wrap: true,
          link_attributes: { rel: 'nofollow', target: "_blank" }
        )
        options = {
          autolink: true,
          space_after_headers: true,
          no_intra_emphasis: true,
          fenced_code_blocks: true,
          tables: true,
          hard_wrap: true,
          xhtml: true,
          lax_html_blocks: true,
          strikethrough: true
        }
        markdown = Redcarpet::Markdown.new(html_render, options)
        markdown.render(text)
    end
end
