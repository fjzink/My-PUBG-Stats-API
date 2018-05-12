require 'httparty'

class PubgController < ApplicationController
    def seasons
        region = params['region']
        pubg = Pubg.new(region)
        response = pubg.seasons
        puts response.body
    end
    
    
    
    
    class Pubg
        include HTTParty
        base_uri 'https://api.playbattlegrounds.com/shards'
        headers "Authorization" => "Bearer #{ENV['PUBG_API_KEY']}", "Accept" => "application/vnd.api+json"

        def initialize(region)
            @region = region
        end

        def seasons
            self.class.get("/#{@region}/seasons")
        end
    end
end
