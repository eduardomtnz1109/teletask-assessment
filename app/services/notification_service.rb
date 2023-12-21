class NotificationService
  def initialize(twilio_service = TwilioService.new)
    @twilio_service = twilio_service
  end

  def send_welcome_notification(user)
    send_notification(to: user.phone_number, message: 'Welcome to our appointment platform!!!')
  end

  def send_appointment_request_notification(appointment)
    message = "#{appointment.patient.name} requested the appointment with you from #{appointment.start_time} to #{appointment.end_time}"
    send_notification(to: appointment.doctor.phone_number, message: message)
  end

  def send_appointment_approval_notification(appointment, approved = true)
    if approved
      message = "You are confirmed with me on the appointment from #{appointment.start_time} to #{appointment.end_time} today!"
    else
      message = "Sorry, we are not able to make it today. Please be patient and come back later tomorrow."
    end
    send_notification(to: appointment.patient.phone_number, message: message)
  end

  def send_appointment_reminder_notification(appointment, remaining_time)
    message = "Your appointment is in #{(remaining_time / 60).to_i} minutes."
    send_notification(to: appointment.patient.phone_number, message: message)
    send_notification(to: appointment.doctor.phone_number, message: message)
  end

  private

  def send_notification(to:, message:)
    begin
      @twilio_service.send_sms(to: to, body: message)
    rescue TwilioServiceError => e
      Rails.logger.error "Twilio Error: #{e.message}"
    end
  end
end
