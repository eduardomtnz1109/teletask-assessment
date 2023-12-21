# spec/services/twilio_service_spec.rb

require 'rails_helper'

RSpec.describe TwilioService, type: :service do
  let(:twilio_service) { TwilioService.new }

  it 'sends an SMS' do
    to = '+1234567890'
    body = 'Test SMS'

    # Stub Twilio messages create method
    allow_any_instance_of(Twilio::REST::Client).to receive_message_chain(:messages, :create).and_raise(Twilio::REST::TwilioError, 'Twilio error')

    expect { twilio_service.send_sms(to: to, body: body) }.to raise_error(TwilioServiceError)
  end
end
