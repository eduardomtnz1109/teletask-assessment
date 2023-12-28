class SlotsController < ApplicationController
  # GET /slots
  def index
    @slots = current_user.slots.for_today.available.order(:start_time)
  end

  # GET /slots/new
  def new
    @slot = Slot.new
  end

  # POST /slots
  def create
    @slot = current_user.slots.new(slot_params)

    if @slot.save
      redirect_to slots_path, notice: 'Slot added successfully.'
    else
      render :new
    end
  end

  # DELETE /slots/:id
  def destroy
    @slot = current_user.slots.find(params[:id])
    @slot.destroy
    redirect_to slots_path, notice: 'Slot removed successfully.'
  end

  private

  def slot_params
    params.require(:slot).permit(:start_time, :end_time)
  end
end
