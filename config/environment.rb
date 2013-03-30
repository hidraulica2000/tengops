# Load the rails application
require File.expand_path('../application', __FILE__)
ENV['SSL_CERT_FILE'] = '/opt/local/etc/certs/cacert.pem'
# Initialize the rails application
Tengops::Application.initialize!
