class Chit_Chat < Sinatra::Base
  helpers do
    def h(text)
      Rack::Utils.escape_html(text)
    end
    def current_user
      User[session[:user_id]] || halt(401, 'Unauthorized.')
    end

    def authorized?
      User[session[:user_id]]
    end
  end
end

