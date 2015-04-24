require 'sunspot/rails/spec_helper'

RSpec.configure do |config|
  # Stubbing Sunspot
  config.before(:each) do
    sunspot_stop
  end

  config.after(:each) do
    sunspot_start
  end

  def sunspot_stop
    Sunspot.session = Sunspot::Rails::StubSessionProxy.new(Sunspot.session)
  end

  def sunspot_start
    Sunspot.session = Sunspot.session.original_session
  end
end
