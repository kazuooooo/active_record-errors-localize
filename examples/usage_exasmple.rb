# NOTE: This is example
# To use in your app, need more rescue_from handler in app
require 'active_support'
require 'active_record-errors-localizer'
using ActiveRecord::Errors::Localize
# Common error handler in all controllers
# class UsersController < ApplicationController
#   include ErrorHandler
# end
module ErrorHandler
  extend ActiveSupport::Concern
  included do
    # ... other rescue_from
    rescue_from ActiveRecord::RecordNotFound do |e|
      render json: { error_message: e.i18n_message }, status: :not_found
    end
    rescue_from ActiveRecord::RecordNotSaved do |e|
      render json: { error_message: e.i18n_message }, status: :bad_request
    end
    rescue_from ActiveRecord::RecordNotDestroyed do |e|
      render json: { error_message: e.i18n_message }, status: :bad_request
    end
    # ... other rescue_from
  end
end
