class AppointmentsController < ApplicationController
  # GET /appointments
  def index
    @appointments = current_user.doctor? ? current_user.doctor_appointments : current_user.patient_appointments
  end

  # GET /appointments/new
  def new
    @appointment = Appointment.new
  end

  # POST /appointments
  def create
    @appointment = Appointment.new(appointment_params)
    @appointment.patient = current_user

    if @appointment.save
      # Send SMS notification to the doctor here
      redirect_to appointments_path, notice: 'Appointment request sent successfully.'
    else
      render :new
    end
  end

  # GET /appointments/:id
  def show
    @appointment = Appointment.find(params[:id])
  end

  # POST /appointments/:id/approve
  def approve
    @appointment = Appointment.find(params[:id])
    if current_user.role.doctor? && @appointment.pending?
      @appointment.approved!
      NotificationService.new.send_appointment_approval_notification(@appointment)
      ReminderJob.set(wait_until: (@appointment.start_time - 1.hour - 15.minutes)).perform_later(@appointment.id)

      redirect_to appointments_path, notice: 'Appointment approved successfully.'
    else
      redirect_to appointments_path, alert: 'Unable to approve appointment.'
    end
  end

  # POST /appointments/:id/decline
  def decline
    @appointment = Appointment.find(params[:id])
    if current_user.role.doctor? && @appointment.pending?
      @appointment.declined!
      NotificationService.new.send_appointment_approval_notification(@appointment, false)

      # Send SMS notification to the patient here
      redirect_to appointments_path, notice: 'Appointment declined successfully.'
    else
      redirect_to appointments_path, alert: 'Unable to decline appointment.'
    end
  end

  private

  def appointment_params
    params.require(:appointment).permit(:start_time, :end_time, :doctor_id, :status)
  end
end
