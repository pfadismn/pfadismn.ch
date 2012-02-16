# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Pfadismn::Application.initialize!

Encoding.default_internal = Encoding.find("UTF-8")
