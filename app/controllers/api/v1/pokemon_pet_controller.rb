
require_relative '../../../common/helper'

module Api
  module V1
    class PokemonPetController < ApplicationController

      def index
        pokemon = PokemonPet.pagination(params[:page], params[:per_page])
        render json: {
          **pagination(pokemon),
          data: pokemon
        }, status: :ok
      end

    end
  end
end