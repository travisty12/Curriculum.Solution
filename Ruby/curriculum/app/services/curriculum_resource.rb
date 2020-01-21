class CurriculumResource

  def self.fetch(method, endpoint, body = nil)
    if (method == 'get')
      response = HTTParty.get('http://localhost:3001' + endpoint).parsed_response
    elsif (method == 'post')
      response = HTTParty.post('http://localhost:3001' + endpoint, body)
    end
    # response["results"][0]["title"] + ' httparty'
  end
end