class ReminderJob < ApplicationJob
  queue_as :default

  def perform(appointment_id)
    appointment = Appointment.find(appointment_id)

    if appointment.approved? # Assuming you have an 'approved' status for approved appointments
      # Calculate the time intervals for reminders
      send_reminder(appointment, 1.hour)
      send_reminder(appointment, 15.minutes)
    end
  end

  private

  def send_reminder(appointment, time_interval)
    reminder_time = appointment.start_time - time_interval

    # Send the reminder if the current time is within the reminder_time window
    if Time.now <= reminder_time
      NotificationService.new.send_appointment_reminder_notification(
        appointment,
        remaining_time
      )
    end
  end
end
