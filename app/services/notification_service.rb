class NotificationService
  def initialize(twilio_service = TwilioService.new)
    @twilio_service = twilio_service
  end

  def send_notification(to:, message:)
    @twilio_service.send_sms(to: to, body: message)
  end
end
