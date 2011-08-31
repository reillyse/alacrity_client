require 'net/http'
require 'net/https'
require 'em-http-request'

class AlacrityClient::Connection

  def initialize(server = "localhost",port = 8888)
    @server = server
    @port = port
  end
  
  def get_player_ranking(player)
    @http ||= Net::HTTP.new(@server, @port)
    path = "/getPlayerRanking?playerNum=#{player}"
    resp, data = @http.get(path, nil)
    return data

  end
  
  def update_player_ranking(player,rank,type)
    @http = Net::HTTP.new(@server, @port)
    path = '/updatePlayerRanking'
    data = "playerNum=#{player}&rank=#{rank}&type=#{type}"
    headers = {
      'Content-Type' => 'application/x-www-form-urlencoded'
    }
    resp, data = @http.post(path, data, headers)
    return data
  end

  def get_player_ranking_async(player,callback_success,callback_err )
    http = EventMachine::HttpRequest.new("http://#{@server}:#{@port}/getPlayerRanking").get :query => {'playerNum' => player}
    http.errback { callback_err.call(http)}
    http.callback { callback_success.call(http)}
  end

  def update_player_ranking_async(player,rank,type,callback_success ,callback_err )

    http = EventMachine::HttpRequest.new("http://#{@server}:#{@port}/updatePlayerRanking").post :body => {'playerNum' => player,'type' => type,'rank'=>rank}
    http.errback { callback_err.call(http)}
    http.callback { callback_success.call(http)}
  end
end

