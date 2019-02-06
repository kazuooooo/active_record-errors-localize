require 'spec_helper'
using ActiveRecord::Errors::Localize
RSpec.describe ActiveRecord::Errors::Localize do
  before do
    class User < ActiveRecord::Base
    end
  end
  describe 'RecordNotFound' do
    let(:name) {'User'}
    let(:primary_key) { 'id' }
    let(:id) { 0 }
    it 'return localized error message' do
      raise ActiveRecord::RecordNotFound.new(
        "Couldn't find #{name} with '#{primary_key}'=#{id}",
        name, primary_key, id
      )
    rescue ActiveRecord::RecordNotFound => e
      localized_message = I18n.t(
        'activerecord.errors.messages.record_not_found',
        model: name.constantize.model_name.human
      )
      expect(e.message).to eq(localized_message)
    end
  end

  describe 'RecordNotSaved' do
  end

  describe 'RecordNotDestroyed' do
  end

  describe 'Otehrs' do
  end
end
