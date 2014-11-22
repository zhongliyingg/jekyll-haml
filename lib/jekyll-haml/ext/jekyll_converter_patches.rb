# encoding: UTF-8

# Patch Jekyll converter usages to pass in extra variables.
# Must be used in conjunction with jekyll-haml release found at
# https://github.com/zhongliyingg/jekyll-haml

module Jekyll
  module Convertible
    def transform(payload = nil, info = nil)
      converters.reduce(content) do |output, converter|
        begin
          if converter.respond_to? :power_convert
            converter.power_convert(output, info, payload)
          else
            converter.convert output
          end
        rescue => e
          # Jekyll.logger.error "Conversion error:", "#{converter.class} encountered an error converting '#{path}'."
          Jekyll.logger.error("Conversion error:", e.to_s)
          raise e
        end
      end
    end
  end
end

module Jekyll
  class Renderer
    def convert(content, info, payload)
      converters.reduce(content) do |output, converter|
        begin
          if converter.respond_to? :power_convert
            converter.power_convert(output, info, payload)
          else
            converter.convert output
          end
        rescue => e
          Jekyll.logger.error "Conversion error:", "#{converter.class} encountered an error converting '#{document.relative_path}'."
          raise e
        end
      end
    end
  end
end