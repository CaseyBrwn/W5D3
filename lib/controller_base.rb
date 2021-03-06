require 'active_support'
require 'active_support/core_ext'
require 'erb'
require_relative './session'
require 'active_support/inflector'
require "byebug"

class ControllerBase
  attr_reader :req, :res, :params

  # Setup the controller
  def initialize(req, res)
    @req = req
    @res = res
    @already_built_response = nil
  end

  # Helper method to alias @already_built_response
  def already_built_response?
    !!@already_built_response 
      
  end

  # Set the response status code and header

  def redirect_to(url)
    raise "Double Render Error" if already_built_response?
    @res.status = 302
    @res.location = url
    @already_built_response = @res
  end

  # Populate the response with content.
  # Set the response's content type to the given type.
  # Raise an error if the developer tries to double render.
  def render_content(content, content_type)
    raise "Double Render Error" if already_built_response?
    @res['Content-Type'] = content_type
    @res.write(content)
    @already_built_response = @res
  end

  # use ERB and binding to evaluate templates
  # pass the rendered html to render_content
  def render(template_name)
    path = "views/#{self.class.to_s.underscore}/#{template_name}.html.erb"
    content = File.read(path)
    template = ERB.new(content)
    final = template.result(binding)
    render_content(final, "text/html")
    debugger
  
  end

  # method exposing a `Session` object
  def session
  end

  # use this with the router to call action_name (:index, :show, :create...)
  def invoke_action(name)
  end
end

