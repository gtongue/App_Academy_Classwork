require 'json'

class Flash
  def initialize(req)
    initial = req.cookies["_rails_lite_app"]
    if initial
      data = JSON.parse(initial)
      @flash = data
    else
      @flash = {}
    end
  end

  def [](key)
    @flash[key]
  end

  def []=(key, val)
    @flash[key] = val
  end

  # serialize the hash into json and save in a cookie
  # add to the responses cookies
  def store_flash(res)
    res.set_cookie(:_rails_lite_app, {path: "/", value: @flash.to_json})
  end
end
