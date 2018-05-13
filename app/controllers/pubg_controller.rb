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

        if response["errors"]
            render json: {"Sorry" => "We couldn't find that player :("}
        else
            player_id = response["data"][0]["id"]
            player_stats = pubg.player_stats(player_id)
            render json: player_stats.body
        end
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

        def player_stats(player_id)
            self.class.get("/#{@region}/players/#{player_id}/seasons/division.bro.official.xb-pre1")
        end
    end
end
