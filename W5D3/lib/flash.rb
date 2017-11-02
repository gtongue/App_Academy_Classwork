require 'json'
require 'byebug'

class Flash
  def initialize(req)
    initial = req.cookies["_rails_lite_app_flash"]
    # debugger
    if !initial.nil?
      data = JSON.parse(initial)
      unless data.nil?
        data.delete("now")
        now = data
      else
        now = {}
      end
    else
      now = {}
    end
    @flash = {now: now}
  end

  def [](key)
    key = key.to_s
    if @flash[key]
      return @flash[key]
    elsif @flash[:now][key]
      return @flash[:now][key]
    elsif @flash[:now][key.to_sym]
      return @flash[:now][key.to_sym]
    else
      return nil
    end
  end

  def []=(key, val)
    key = key.to_s
    @flash[key] = val
  end

  def now
    @flash[:now]
  end 

  def store_flash(res)
    res.set_cookie(:_rails_lite_app_flash, {path: "/", value: @flash.to_json})
  end
end
