# frozen_string_literal: true

require 'yaml'
require_relative '../common/constants'

# Application controller
class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token
  rescue_from Exception, with: :server_internal_error
  rescue_from ActiveRecord::DeleteRestrictionError, with: :bad_request
  rescue_from ActionController::ParameterMissing, with: :bad_request
  rescue_from NoMethodError, with: :bad_request
  rescue_from ActionController::RoutingError, with: :not_found
  rescue_from AbstractController::ActionNotFound, with: :not_found
  rescue_from ActionController::MethodNotAllowed, with: :server_internal_error
  rescue_from ActionController::UnknownHttpMethod, with: :server_internal_error
  rescue_from ActionController::NotImplemented, with: :bad_request
  rescue_from ActionController::UnknownFormat, with: :bad_request
  rescue_from ActionController::InvalidAuthenticityToken, with: :bad_request
  rescue_from ActionController::InvalidCrossOriginRequest, with: :bad_request
  rescue_from ActionDispatch::Http::Parameters::ParseError, with: :bad_request
  rescue_from ActionController::BadRequest, with: :bad_request
  rescue_from ActionController::ParameterMissing, with: :bad_request
  rescue_from Rack::QueryParser::ParameterTypeError, with: :bad_request
  rescue_from Rack::QueryParser::InvalidParameterError, with: :bad_request
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ActiveRecord::StaleObjectError, with: :server_internal_error
  rescue_from ActiveRecord::RecordInvalid, with: :bad_request
  rescue_from ActiveRecord::RecordNotSaved, with: :bad_request

  before_action :authenticate_user

  def router_not_found
    render json: {
      error: 'Not Found',
      error_detail: "Routing doesn't work"
    }, status: :not_found
  end

  private

  def server_internal_error(error = '', message = '')
    render json: {
      error: 'Internal Server Error',
      error_detail: message,
      exception: Rails&.env&.production? ? '' : error
    }, status: :internal_server_error
  end

  def bad_request(error = '')
    render json: {
      error: 'Bad Request',
      error_detail: error
    }, status: :bad_request
  end

  def not_found(error = '')
    render json: {
      error: 'Not Found',
      error_detail: error
    }, status: :not_found
  end

  def forbidden(_error = '')
    head :forbidden
  end

  def authenticate_user
    data_permission = YAML.load_file('app/common/permission.yaml')
    original_fullpath = request.original_fullpath.to_s.gsub(%r{(/\?|\?).*}, '').split('/').map(&:strip).reject(&:empty?)
    current_user ||= AuthorizeApiRequest.new(request.headers).call
    if current_user
      user_group_role = current_user.group.group_role
      unless user_group_role == GroupRole.new.admin
        temp_data = data_permission
        original_fullpath.each do |url|
          return forbidden unless temp_data.present?

          temp_data = temp_data[url] || temp_data['<param>']
        end
        roles = temp_data[request.method]
        p roles
        return if roles.present? && (roles.include? user_group_role)

        forbidden
      end
    else
      head :unauthorized unless current_user
    end
  end
end
