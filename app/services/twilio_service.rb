class TwilioService
  def initialize
    @client = Twilio::REST::Client.new
    @messaging_service_sid = ENV['TWILIO_MESSAGING_SERVICE_SID']
  end

  def verify_service
    @client.verify.v2.services(ENV['TWILIO_VERIFY_SERVICE_SID'])
  end

  def send_sms(to:, body:)
    begin
      @client.messages.create(
        messaging_service_sid: @messaging_service_sid,
        to: to,
        body: body
      )
    rescue Twilio::REST::TwilioError => e
      raise TwilioServiceError, "Failed to send SMS: #{e.message}"
    end
  end
end
