class TrackReceiver

  def initialize
    self.base = 'http://localhost:3001/'
  end

  def self.get_tracks_httparty
  
    # response = HTTParty.get('https://api.nytimes.com/svc/topstories/v2/home.json?api-key=' + ENV['NYT_API_KEY'])
    response = HTTParty.get(self.base + 'tracks')
    # response["results"][0]["title"] + ' httparty'
  end

  def self.get_tracks_restclient
    # response = RestClient::Request.execute( :method => :get, :url => 'https://api.nytimes.com/svc/topstories/v2/home.json?api-key='+ENV['NYT_API_KEY'] )
    response = RestClient::Request.execute( :method => :get, :url => self.base + 'tracks' )
    # JSON.parse(response)["results"][0]["title"] + ' restclient'
  end
end