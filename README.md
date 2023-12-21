# Appointment Platform Documentation

## Overview

The Appointment Platform is a web application that facilitates appointments between doctors and patients. It allows doctors to manage their schedules and patients to book appointments with available doctors.

### Features

- User roles: Doctor and Patient.
- Doctors can view patients' lists, manage time slots, and view appointments.
- Patients can view available doctors, book appointments, and manage their appointments.
- Real-time SMS notifications for appointment requests, approvals, and reminders.

## Tech Stack

- Ruby on Rails: Backend framework for building the web application.
- PostgreSQL: Database for storing application data.
- Twilio: Integration for sending real-time SMS notifications.
- Bootstrap: CSS framework for styling the user interface.
- RSpec: Testing framework for unit and integration testing.

## Installation

Follow these steps to set up and run the Appointment Platform on your local machine.

### Prerequisites

- Ruby 3.2.2
- Rails 7.1.2
- PostgreSQL
- Twilio account with API credentials

### Setup

1. Clone the repository:

   ```bash
   git clone https://github.com/your/repo.git
   cd appointment-platform
2. Install dependencies:

   ```bash
   bundle install
3. Create the database:

   ```bash
   rails db:create
   rails db:migrate
3. Configure Twilio:
    - Obtain your Twilio API credentials (Account SID and Auth Token).
    - Create a .env file in the project root directory and add your credentials:

    ```bash
    TWILIO_ACCOUNT_SID=your_account_sid
    TWILIO_AUTH_TOKEN=your_auth_token
    TWILIO_VERIFY_SERVICE_SID=your_twilio_verify_service_sid
    TWILIO_MESSAGING_SERVICE_SID=your_twilio_messaging_service_sid

    ```

### Running the Application
1. Start the Rails server:
    ```bash
    bin/rails server
    ```
2. Access the application in your web browser at `http://localhost:3000`

### Testing
To run the RSpec tests, use the following command: `rspec`

## Workflow

### User Roles
- Doctors and patients can sign up for an account.
- Upon sign-up, they can select their role (doctor or patient).

### Doctor Workflow
1. View Patients: Doctors can view the list of patients.
2. Manage Time Slots: Doctors can create available 30-minute time slots from 9 am to 5 pm for the current day.
3. View Appointments: Doctors can see the list of appointments, filtered by approved and pending.

### Patient Workflow
1. View Doctors: Patients can see the list of available doctors.
2. Book Appointments: Patients can view doctor information and book appointments from available time slots for the current day.
3. View Appointments: Patients can see their appointment list.

### Real-Time SMS Notifications
- When a patient books an appointment, an SMS notification is sent to the doctor.
- Doctors can approve or decline appointment requests, and SMS notifications are sent to patients with the decision.
- SMS reminders are sent to patients before appointments (2 hours, 1 hour, 15 minutes, and 5 minutes before the appointment time).

## Considerations

The app has a limited appointment workflow, such as only allowing time slots for the current day and handling the responses for SMS notifications with codes like REPLY or APPROVE. We can also add more graceful error handling logic to the Twilio integrations, so that users can get the status of the messages and verify that the requests are being processed. There are still many areas to improve if I have more time in mind, but overall it was a great project to work on.
