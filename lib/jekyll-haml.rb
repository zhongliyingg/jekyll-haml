require "jekyll-haml/version"
require "haml"

require "jekyll-haml/tags/haml_partial"
require "jekyll-haml/ext/convertible"
require "jekyll-haml/ext/jekyll_converter_patches"
require 'jekyll-haml/ext/maybe'

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

    def convert(content, info = nil, payload = {})
      ::Haml::Engine.new(content).render
    end

    def power_convert(content, info = nil, payload = {})
      payload = Maybe.new(payload)
      ::Haml::Engine.new(content).render(Object.new, {info: info, payload: payload, site: payload['site'], page: payload['page']})
    end
  end
end
