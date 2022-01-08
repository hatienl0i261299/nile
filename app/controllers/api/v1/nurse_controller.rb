# frozen_string_literal: true

require_relative '../../../../helper'

module Api
  module V1
    class NurseController < ApplicationController
      def index
        render json: Nurse.all, status: :ok
      end

      def show
        nurse = Nurse.find(params[:id])
        render json: nurse, status: :ok
      end

      def update
        nurse = Nurse.find(params[:nurse_id])
        num = add(1, 2)
        p num
        nurse.name = params[:name]
        nurse.phone = params[:phone]
        nurse.address = params[:address]
        nurse.save!
        render json: :ok, status: :no_content
      end

      def update_nurse_booked
        nurse_schedule_id = params[:nurse_schedule_id]
        booked = params[:booked]
        item = NurseSchedule.find(nurse_schedule_id)
        item.booked = booked if item.valid?
        item.save!
        render json: :ok, status: :ok
      end
    end
  end
end
