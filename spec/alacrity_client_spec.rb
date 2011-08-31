require 'alacrity_client/connection'
describe AlacrityClient::Connection do


  # this really isn't much use as a general test file, it very much relies
  # on what is currently defined on the server side of things and can really
  # only be used with a correctly configured server (i.e. the aggragator)
  # for example the "kills" and "eats" are very much game specific
  # that said, it should still connect if you have the server running in the
  # right place (localhost:8888 at the moment) and the tests should still pass
  # so it does test the structure of the api
  
  it "should connect and get correctly async" do

    EventMachine.run { 
      client = AlacrityClient::Connection.new
      client.get_player_ranking_async(1,lambda { |http| p http.response   ;EM.stop},lambda { |http| p "Error.. #{http.error}"  ;EM.stop})

    }
  end

  it "it should connect and post correctly async" do
    client = AlacrityClient::Connection.new
    EventMachine.run { 
      client.update_player_ranking_async(1,100,"kills",lambda { |http| p http.response  ;EM.stop},lambda { |http| p "Error.. #{http.error}"  ;EM.stop  })
    }
    EventMachine.run { 
      client.update_player_ranking_async(1,100,"eats",lambda { |http| p http.response  ;EM.stop},lambda { |http| p "Error.. #{http.error}" ;EM.stop })
    }
    EventMachine.run { 
      client.get_player_ranking_async(1,lambda { |http| p http.response  ;EM.stop },lambda { |http| p "Error.. #{http.error}" ;EM.stop })
    }
  end

  it "should connect and get ranking synchronously too" do
    client = AlacrityClient::Connection.new
    client.get_player_ranking(1)
  end

  
  it "should connect and update synchronously too" do
    client = AlacrityClient::Connection.new
    client.update_player_ranking(1,100,"kills")
  end

  it "should be able to operate asynchronously"  do
    client = AlacrityClient::Connection.new
    EventMachine.run { 
      client.update_player_ranking_async(1,100,"kills",lambda { |http| puts "working" ;  puts http.response ;EM.stop}, lambda{ |http| puts "error" ; puts http.error ; EM.stop})
      puts "should happen first or in between not after"
    }
  end
end
