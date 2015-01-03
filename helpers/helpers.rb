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
    def find_distance(ulat,ulong,plat,plong)
      user_long = ulong * Math::PI / 180
      user_lat = ulat * Math::PI / 180
      post_lat = plat * Math::PI / 180
      post_long = plong * Math::PI / 180

      dlat = (post_lat - user_lat)
      dlong = (post_long - user_long)

      a = Math.sin(dlat/2)**2 + Math.cos(user_lat) * Math.cos(post_lat) * Math.sin(dlong/2)**2
      c = 2 * Math.atan2(Math.sqrt(a),Math.sqrt(1 - a))

      distance = 6378.1 * c

      return distance
    end
  end
end

