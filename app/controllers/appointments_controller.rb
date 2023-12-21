class AppointmentsController < ApplicationController
  before_action :authenticate_user! # Add authentication logic here

  def index
    @appointments = current_user.doctor? ? current_user.doctor_appointments : current_user.patient_appointments
  end

  def new
    @appointment = Appointment.new
  end

  def create
    @appointment = Appointment.new(appointment_params)
    @appointment.patient = current_user # Assign the current user as the patient

    if @appointment.save
      # Send SMS notification to the doctor here
      redirect_to dashboard_path, notice: 'Appointment request sent successfully.'
    else
      render :new
    end
  end

  def show
    @appointment = Appointment.find(params[:id])
  end

  def approve
    @appointment = Appointment.find(params[:id])
    if current_user.role.doctor? && @appointment.pending?
      @appointment.approved!
      # Send SMS notification to patient here
      redirect_to appointments_path, notice: 'Appointment approved successfully.'
    else
      redirect_to appointments_path, alert: 'Unable to approve appointment.'
    end
  end

  def decline
    @appointment = Appointment.find(params[:id])
    if current_user.role.doctor? && @appointment.pending?
      @appointment.declined!
      # Send SMS notification to patient here
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
