# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Bsmi::Application.initialize!

# E-mail settings
#ActionMailer::Base.delivery_method = :sendmail
#ActionMailer::Base.perform_deliveries = true
#ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.delivery_method = :smtp
#ActionMailer::Base.delivery_method = :test if Rails.env.test?
ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.smtp_settings = {
 :address => "localhost",
 :enable_starttls_auto => false
}

