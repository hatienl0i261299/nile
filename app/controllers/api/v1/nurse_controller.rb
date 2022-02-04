# frozen_string_literal: true

require_relative '../../../common/helper'
require_relative '../../../common/constants'

module Api
  module V1
    class NurseController < ApplicationController
      def index
        render json: Nurse.all, status: :ok
      end

      def show
        nurse_id = params[:id]
        nurse = Nurse.eager_load(:schedules).find(nurse_id)
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

      def destroy
        nurse = Nurse.find(params[:id])
        nurse.destroy!
        head :no_content
      end

      def create
        nurse = Nurse.new(name: params[:name], phone: params[:phone], address: params[:address])
        nurse.save!
        Schedule.all.map do |schedule|
          NurseSchedule.create do |nurse_schedule|
            nurse_schedule.nurse = nurse
            nurse_schedule.schedule = schedule
          end
        end

        render json: nurse, status: :created
      end

      def update_nurse_booked
        data = params[:_json]
        data.map do |item|
          puts item[:booked]
          nurse_schedule = NurseSchedule.find(item[:id])
          booked = str_to_boolean(item[:booked])
          if [true, false].include? booked
            nurse_schedule.booked = item[:booked]
            nurse_schedule.save!
          else
            return bad_request "'#{item[:booked]}' is not a valid type"
          end
        end
        head :no_content
      end
    end
  end
end
