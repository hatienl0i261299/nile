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
        nurse = Nurse.select(
          [
            'nurses.id ',
            'nurses.name',
            'nurses.phone',
            'nurses.address',
            'nurse_schedules.id as nurse_schedule_id',
            'nurse_schedules.booked',
            'nurse_schedules.created_at as nurse_schedule_created_at',
            'nurse_schedules.updated_at as nurse_schedule_updated_at',
            'schedules.time_start',
            'schedules.time_end',
            'nurses.created_at',
            'nurses.updated_at'
          ].map(&:strip).join(', ')
        ).where(id: nurse_id).joins(nurse_schedules: [:schedule]).order('schedules.id ASC')
        return bad_request("Couldn't find Nurse with id='#{nurse_id}'") unless nurse.present?

        nurse_info = {
          id: nurse[0][:id],
          name: nurse[0][:name],
          phone: nurse[0][:phone],
          address: nurse[0][:address],
          created_at: nurse[0][:created_at].strftime(FORMAT_DATETIME_OUTPUT),
          updated_at: nurse[0][:updated_at].strftime(FORMAT_DATETIME_OUTPUT),
        }
        render json: {
          **nurse_info,
          schedules: nurse.map do |item|
            {
              id: item[:nurse_schedule_id],
              booked: item[:booked],
              time_start: item[:time_start],
              time_end: item[:time_end],
              created_at: item[:nurse_schedule_created_at].strftime(FORMAT_DATETIME_OUTPUT),
              updated_at: item[:nurse_schedule_updated_at].strftime(FORMAT_DATETIME_OUTPUT),
            }
          end
        }, adapter: nil, status: :ok
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
