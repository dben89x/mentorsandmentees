require 'json'

access_key_id = ENV["ACCESS_KEY_ID"]
secret_access_key = ENV["SECRET_ACCESS_KEY"]

creds = Aws::Credentials.new(access_key_id, secret_access_key)
Aws::Rails.add_action_mailer_delivery_method(
	:aws_sdk, credentials: creds, region: 'us-east-1'
)
