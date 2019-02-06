require "active_record/errors/localize/version"
require 'active_record'
require 'active_support'
require 'i18n'
require 'pry'
module ActiveRecord
  module Errors
    module Localize
      refine ActiveRecordError do
        def error_under_scored_name
          self.class.name.demodulize.underscore
        end
      end
      refine RecordNotFound do
        def full_message
          I18n.t(
            "activerecord.errors.messages.#{error_under_scored_name}",
            model: model.constantize.model_name.human,
            primary_key: primary_key,
            id: id,
          )
        end
      end

      refine RecordNotSaved do
        def full_message
          I18n.t(
            "activerecord.errors.messages.#{error_under_scored_name}",
            record: record.model_name.human,
            errors: record.errors.full_messages.join(', ')
          )
        end
      end

      refine RecordNotDestroyed do
        def full_message
          I18n.t(
            "activerecord.errors.messages.#{error_under_scored_name}",
            record: record.model_name.human,
            errors: record.errors.full_messages.join(', ')
          )
        end
      end
    end
  end
end
