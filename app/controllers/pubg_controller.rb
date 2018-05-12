require 'httparty'

class PubgController < ApplicationController
    def seasons
        pubg = Pubg.new
        response = pubg.seasons
        puts response.body
    end
    
    
    
    
    class Pubg
        include HTTParty
        base_uri 'https://api.playbattlegrounds.com/shards/xbox-na'
        headers "Authorization" => "Bearer #{ENV['PUBG_API_KEY']}", "Accept" => "application/vnd.api+json"

        def seasons
            self.class.get('/seasons')
        end
    end
end
