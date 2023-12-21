class VerifyService
  def initialize(twilio_service = TwilioService.new)
    @verify_service = twilio_service.verify_service
  end

  def send_code(phone_number)
    begin
      @verify_service.verifications.create(
        to: phone_number,
        channel: 'sms'
      )
    rescue Twilio::REST::TwilioError => e
      raise VerifyServiceError, "Failed to send verification code: #{e.message}"
    end
  end

  def verify_code(phone_number, code)
    begin
      verification_check = @verify_service.verification_checks.create(
        to: phone_number,
        code: code
      )

      verification_check.status == 'approved'
    rescue Twilio::REST::TwilioError => e
      raise VerifyServiceError, "Failed to verify code: #{e.message}"
    end
  end
end
