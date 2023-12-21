class UsersController < ApplicationController
  before_action :set_user

  # GET /users/:id/start_onboarding
  def start_onboarding
    # This action will just render the start_onboarding view
  end

  # GET /users/:id/phone_verify
  def phone_verify
    # This action will just render the phone_verify view
  end

  # POST /users/:id/process_details
  def process_details

  end

  # PATCH /users/:id/complete_verification
  def complete_verification

  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :phone_number, :user_type)
  end

  def verification_params
    params.require(:user).permit(:verification_code)
  end
end
