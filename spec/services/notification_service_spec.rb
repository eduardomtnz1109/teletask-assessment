# spec/services/notification_service_spec.rb
require 'rails_helper'

RSpec.describe NotificationService, type: :service do
  let(:notification_service) { NotificationService.new }

  describe '#send_welcome_notification' do
    it 'sends a welcome notification' do
      user = create(:user) # Create a user object as needed
      expect { notification_service.send_welcome_notification(user) }.not_to raise_error
    end
  end

  # Write similar tests for other methods like send_appointment_request_notification,
  # send_appointment_approval_notification, and send_appointment_reminder_notification
end
