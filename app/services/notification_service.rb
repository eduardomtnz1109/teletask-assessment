class NotificationService
  def initialize(twilio_service = TwilioService.new)
    @twilio_service = twilio_service
  end

  def send_welcome_notification(user)
    send_notification(to: user.phone_number, message: 'Welcome to our appointment platform!!!')
  end

  def send_appointment_request_notification(appointment)
    send_notification(
      to: appointment.doctor.phone_number,
      message: "#{appointment.patient.name} requested the appointment with you from #{appointment.start_time} to #{appointment.end_time}"
    )
  end

  def send_appointment_approval_notification(appointment, approved = true)
    if approved
      send_notification(
        to: appointment.patient.phone_number,
        message: "You are confirmed with me on the appointment from #{@appointment.start_time} to #{@appointment.end_time} today!"
      )
    else
      send_notification(
        to: appointment.patient.phone_number,
        message: "Sorry, we are not able to make it today. Please be patient and come back later tomorrow."
      )
    end
  end

  private

  def send_notification(to:, message:)
    @twilio_service.send_sms(to: to, body: message)
  rescue TwilioError => e
    Rails.logger.error "Twilio Error: #{e.message}"
  end
end
