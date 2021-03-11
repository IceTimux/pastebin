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

def db_format(date)
  date.strftime('%Y-%m-%d %H:%M:%S')
end

def simple_format(date)
  date.strftime('%B %e %Y @ %H:%M')
end
