class CurriculumResource

  def self.fetch(method, endpoint, body = nil)
    if (method == 'get')
      response = HTTParty.get('http://localhost:3001' + endpoint)
    elsif (method == 'post')
      body.each { |key, value| endpoint += key + "=" + value + "&" }
      response = HTTParty.post('http://localhost:3001' + endpoint)
    elsif (method == 'put')
      body.each { |key, value| endpoint += key + "=" + value + "&" }
      response = HTTParty.put('http://localhost:3001' + endpoint)
    elsif (method == 'delete')
      response = HTTParty.delete('http://localhost:3001' + endpoint)
    end
  end
end