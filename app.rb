class Chit_Chat < Sinatra::Base

  configure :development do
    register Sinatra::Reloader
    Dir['./controllers/*.rb'].each {|file| also_reload file }
    Dir['./helpers/*.rb'].each {|file| also_reload file }
  end

  use Rack::Session::Cookie, :key=> 'rack.session',
      :secret =>  ENV['SESSION_SECRET'],
      :expire_after => 2592000

  use Rack::Protection::AuthenticityToken
  use Rack::PostBodyContentTypeParser

endgit 