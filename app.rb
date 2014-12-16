class Chit_Chat < Sinatra::Base

  configure :development do
    register Sinatra::Reloader
    Dir['./controllers/*.rb'].each {|file| also_reload file }
    Dir['./helpers/*.rb'].each {|file| also_reload file }
  end

  use Rack::Session::Cookie, :key=> 'rack.session',
      #:secret =>  ENV['SESSION_SECRET']
      :expire_after => 2592000,
      :secret => '90d0610a8ae346d7c1952d331c1759c95e2955acd74df1a7271c9a9130a7233c'

  use Rack::Protection::AuthenticityToken

end