task :create_default_for_today => :environment do
  User.doctors.find_each do |doctor|
    doctor.create_default_slots
  end
end
