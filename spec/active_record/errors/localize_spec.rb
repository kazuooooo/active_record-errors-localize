require 'spec_helper'
using ActiveRecord::Errors::Localize
RSpec.describe ActiveRecord::Errors::Localize do
  before do
    class User < ActiveRecord::Base
    end
  end
  describe 'RecordNotFound' do
    let(:name) { 'User' }
    let(:primary_key) { 'id' }
    let(:id) { 0 }
    it 'Return localized error message' do
      raise ActiveRecord::RecordNotFound.new(
        "Couldn't find #{name} with '#{primary_key}'=#{id}",
        name, primary_key, id
      )
    rescue ActiveRecord::RecordNotFound => e
      localized_message = I18n.t(
        'activerecord.errors.messages.record_not_found',
        model: name.constantize.model_name.human
      )
      expect(e.full_message).to eq(localized_message)
    end
  end

  describe 'RecordNotSaved' do
    let(:record) { User.new }
    it 'Return localized error message' do
      raise ActiveRecord::RecordNotSaved.new(
        'You cannot call create unless the parent is saved',
        record
      )
    rescue ActiveRecord::RecordNotSaved => e
      localized_message = I18n.t(
        'activerecord.errors.messages.record_not_saved',
        record: record.model_name.human
      )
      expect(e.full_message).to eq(localized_message)
    end
  end

  describe 'RecordNotDestroyed' do
    let(:record) { User.new }
    it 'Return localized error message' do
      raise ActiveRecord::RecordNotDestroyed.new('Failed to destroy the record', record)
    rescue ActiveRecord::RecordNotDestroyed => e
      localized_message = I18n.t(
        'activerecord.errors.messages.record_not_destroyed',
        record: record.model_name.human
      )
      expect(e.full_message).to eq(localized_message)
    end
  end
end
