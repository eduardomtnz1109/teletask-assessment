class UsersController < ApplicationController
  before_action :set_user, only: [:start_onboarding, :phone_verify, :process_details, :complete_verification]

  def start_onboarding
    # This action will just render the start_onboarding view
  end

  def phone_verify
    # This action will just render the phone_verify view
  end

  def resend_verify_code
    if send_verification_code(@user)
      flash.now[:notice] = 'Verification code resent successfully.'
    else
      flash.now[:alert] = 'Failed to resend verification code.'
    end
    redirect_to phone_verify_user_path(@user)
  end


  def process_details
    if @user.update(user_params)
      if send_verification_code(@user)
        redirect_to phone_verify_user_path(@user), notice: "Verification code sent to #{@user.phone_number}."
      else
        flash.now[:alert] = 'Failed to send verification code.'

        render :start_onboarding
      end
    else
      render :start_onboarding
    end
  end

  def complete_verification
    if verify_code(@user.phone_number, verification_params[:verification_code])
      @user.update(phone_verified: true)
      @user.create_default_slots if @user.doctor?
      send_welcome_notification(@user)

      redirect_to dashboard_index_path, notice: 'Your account has been successfully created and verified'
    else
      flash.now[:alert] = 'Incorrect verification code.'

      render :phone_verify
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: 'User not found'
  end

  def user_params
    params.require(:user).permit(:name, :phone_number, :role)
  end

  def verification_params
    params.require(:user).permit(:verification_code)
  end

  def send_verification_code(user)
    VerifyService.new.send_code(user.phone_number)
  rescue TwilioError => e
    Rails.logger.error "Twilio Error: #{e.message}"
    false
  end

  def verify_code(phone_number, code)
    VerifyService.new.verify_code(phone_number, code)
  end

  def send_welcome_notification(user)
    NotificationService.new.send_notification(to: user.phone_number, message: 'Welcome to our appointment platform!!!')
  rescue TwilioError => e
    Rails.logger.error "Twilio Error: #{e.message}"
  end
end
