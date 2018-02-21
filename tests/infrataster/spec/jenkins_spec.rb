require 'spec_helper'

describe server(:jenkins) do
  describe http('http://192.168.39.3:8080/login?from=%2F') do
    it "responds content including 'Jenkins'" do
      expect(response.body).to include('Jenkins')
    end

    it "responds as 'text/html;charset=UTF-8'" do
      expect(response.headers['content-type']).to eq('text/html;charset=UTF-8')
    end
  end
end
