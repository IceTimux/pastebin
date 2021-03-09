# frozen_string_literal: true

helpers do
  def protected!
    return if authorized?

    headers['WWW-Authenticate'] = 'Basic realm="Restricted Area"'
    halt 401, "Not authorized\n"
  end

  def authorized?
    username = ENV['USERNAME']
    password = ENV['PASSWORD']
    @auth ||= Rack::Auth::Basic::Request.new(request.env)
    @auth.provided? and @auth.basic? and @auth.credentials and
      @auth.credentials == [username, password]
  end
end
