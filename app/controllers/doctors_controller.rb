class DoctorsController < ApplicationController
  # GET /doctors
  def index
    @doctors = User.doctors
  end

  # GET /doctors/:id
  def show
    @doctor = User.find(params[:id])
    @available_slots = @doctor.slots.available
    @appointment = Appointment.new
  end

  # POST /doctors/:id/create_appointment
  def create_appointment
    @doctor = User.find(params[:id])
    slot = @doctor.slots.available.find_by_id(appointment_params[:slot_id])
    @appointment = current_user.patient_appointments.new(
      start_time: slot.start_time,
      end_time: slot.end_time,
      doctor: @doctor,
      patient: current_user,
      status: 'pending'
    )

    if @appointment.save
      slot.update(state: false)
      NotificationService.new.send_appointment_request_notification(@appointment)

      redirect_to appointments_path, notice: 'Appointment requested successfully.'
    else
      flash.now[:alert] = 'Something went wrong, please refresh the page and try again.'

      render :show
    end
  end

  private

  def appointment_params
    params.require(:appointment).permit(:slot_id)
  end
end
