require_relative '../phase2/controller_base'
require 'active_support'
require 'active_support/core_ext'
require 'active_support/inflector'
require 'erb'

module Phase3
  class ControllerBase < Phase2::ControllerBase
    # use ERB and binding to evaluate templates
    # pass the rendered html to render_content
    def render(template_name)
      contents = File.read("views/#{self.class.to_s.underscore}/#{template_name.to_s}.html.erb")
      html = ERB.new(contents).result(binding)
      self.render_content(html, "text/html")
      #does inheritance just give you methods or instance variables as well? 
    end
  end
end
