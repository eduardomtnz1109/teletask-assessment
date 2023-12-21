class TwilioService
  def initialize
    @client = Twilio::REST::Client.new
    @messaging_service_sid = ENV['TWILIO_MESSAGING_SERVICE_SID']
  end

  def verify_service
    @client.verify.v2.services(ENV['TWILIO_VERIFY_SERVICE_SID'])
  end

  def send_sms(to:, body:)
    @client.messages.create(
      messaging_service_sid: @messaging_service_sid,
      to: to,
      body: body
    )
  rescue Twilio::REST::RestError => e
    raise TwilioError, e.message
  end
end
