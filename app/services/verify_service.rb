class VerifyService
  def initialize(twilio_service = TwilioService.new)
    @verify_service = twilio_service.verify_service
  end

  def send_code(phone_number)
    @verify_service.verifications.create(
      to: phone_number,
      channel: 'sms'
    )
  rescue TwilioError => e
    raise e
  end

  def verify_code(phone_number, code)
    verification_check = @verify_service.verification_checks.create(
      to: phone_number,
      code: code
    )

    verification_check.status == 'approved'
  rescue TwilioError => e
    raise e
  end
end
