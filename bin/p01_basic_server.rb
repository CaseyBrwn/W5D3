require 'rack'
require 'byebug'



# app = Proc.new do |env|
#   req = Rack::Request.new(env)
#   res = Rack::Response.new
#   res['Content-Type'] = 'text/html'
#   res.write("Hello world!")
#   res.finish
# end

# Rack::Server.start(
#   app: app,
#   Port: 3000
# )

app = Proc.new do |env|
    # string = ""
  req = Rack::Request.new(env)
  res = Rack::Response.new
  res.status = '200'
  res['Content-Type'] = 'text/html'
  res.write(req.path_info)
  res.finish
end


Rack::Server.start(
  app: app,
  Port: 3000
)