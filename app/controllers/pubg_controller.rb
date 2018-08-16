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
        season_id = params["season_id"]
        pubg = Pubg.new(region) 
        response = pubg.player(player_name)

        if response["errors"]
            render status: 404, json: {"message" => "Sorry, that player could not be found."}
        else
            player_id = response["data"][0]["id"]
            player_stats = pubg.player_stats(player_id, season_id)
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

        def player_stats(player_id, season_id)
            self.class.get("/#{@region}/players/#{player_id}/seasons/#{season_id}")
        end
    end
end
