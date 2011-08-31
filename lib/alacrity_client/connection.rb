require 'net/http'
require 'net/https'
require 'em-http-request'

class AlacrityClient::Connection

  def initialize
    @server = "http://localhost"
    @port = 8888
  end
  
  def get_player_ranking(player)
    @http ||= Net::HTTP.new('localhost', 8888)
    path = "/getPlayerRanking?playerNum=#{player}"
    
    # GET request -> so the host can set his cookies
    resp, data = @http.get(path, nil)
      return data
    rescue => e
    puts e.message
  end
  
  def update_player_ranking(player,rank,type)
    @http ||= Net::HTTP.new('localhost', 8888)
    path = '/updatePlayerRanking'
    data = "playerNum=#{player}&rank=#{rank}&type=#{type}"
    headers = {
      'Content-Type' => 'application/x-www-form-urlencoded'
    }

    resp, data = @http.post(path, data, headers)

    return data
    rescue => e
    puts e.message
  end

  def get_player_ranking_async(player,callback_success = lambda { EM.stop},callback_err = lambda { EM.stop})

  EventMachine.run {
      http = EventMachine::HttpRequest.new("#{@server}:#{@port}/getPlayerRanking").get :query => {'playerNum' => player}

      http.errback { callback_err.call(http)}
      http.callback { callback_success.call(http)}
    }
    end

  
  def update_player_ranking_async(player,rank,type,callback_success = lambda { EM.stop},callback_err = lambda { EM.stop})

  EventMachine.run {
      http = EventMachine::HttpRequest.new("#{@server}:#{@port}/updatePlayerRanking").post :body => {'playerNum' => player,'type' => type,'rank'=>rank}

      http.errback { callback_err.call(http)}
      http.callback { callback_success.call(http)}
    }
    end
end

