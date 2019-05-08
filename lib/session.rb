require 'json'

class Session
  # find the cookie for this app
  # deserialize the cookie into a hash
  # look to see if req has cookie with value of "_rails_lite_app"
  # if it exists turn req cookie at key of _rails_lite_app into ruby hash
  # else set cookie to {}
  def initialize(req)
  
    @req = req
    # debugger
    if @req.cookies.keys.first == "_rails_lite_app"
      @cookie = JSON.parse(@req.cookies.values.first)
      # debugger
    else
      @cookie = {}
    end
  end

  def [](key)
    @cookie[key]
  end

  def []=(key, val)
  end

  # serialize the hash into json and save in a cookie
  # add to the responses cookies
  def store_session(res)
    res.set_cookie(@cookie.to_json)
    debugger
  end
end
