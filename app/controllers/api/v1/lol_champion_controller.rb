# frozen_string_literal: true

module Api
  module V1
    class LolChampionController < ApplicationController
      def index
        lol_champion = LolChampion
                       .includes(:tree)
                       .where("tree_id = #{params[:tree_id]}")
        render json: lol_champion, status: :ok
      end
    end
  end
end
