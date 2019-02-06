require "active_record/errors/localize/version"
require 'active_record'
require 'active_support'
require 'i18n'
require 'pry'
module ActiveRecord
  module Errors
    module Localize
      refine RecordNotFound do
        def message
          error_under_scored_name = self.class.name.demodulize.underscore
          I18n.t(
            "activerecord.errors.messages.#{error_under_scored_name}",
            model: model.constantize.model_name.human,
          )
        end
      end
    end
  end
end
