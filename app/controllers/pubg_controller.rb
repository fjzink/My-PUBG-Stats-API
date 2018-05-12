require 'httparty'

class PubgController < ApplicationController
    def seasons
        region = params['region']
        pubg = Pubg.new(region)
        response = pubg.seasons
        render json: response.body
    end

    def player
        region = params['region']
        player_name = params['player_name']
        pubg = Pubg.new(region) 
        response = pubg.player(player_name)
        render json: response.body
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

        def player(name)
            options = { query: { "filter[playerNames]" => "#{name}" } }
            self.class.get("/#{@region}/players", options)
        end
    end
end
