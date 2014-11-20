require "jekyll-haml/version"
require "haml"

require "jekyll-haml/tags/haml_partial"
require "jekyll-haml/ext/convertible"

module Jekyll
  class HamlConverter < Converter
    safe true
    priority :low

    def matches(ext)
      ext =~ /haml/i
    end

    def output_ext(ext)
      ".html"
    end

    def convert(content, info = nil, payload = nil)
      ::Haml::Engine.new(content).render(Object.new, {info: info, payload: payload, site: payload['site']})
    end
  end
end
