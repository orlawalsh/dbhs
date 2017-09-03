require 'carrierwave/storage/fog'
CarrierWave.configure do |config|

    # Use local storage if in development or test
  if Rails.env.development? || Rails.env.test?
    CarrierWave.configure do |config|
      config.storage = :file
    end
  end

    # Use AWS storage if in production
  if Rails.env.production?
    CarrierWave.configure do |config|
      config.storage = :fog
    end
  end
    config.fog_credentials = {

    :provider               => 'AWS',                             # required
    :aws_access_key_id      => 'AKIAJC373IOC3YCRL5KA',            # required
    :aws_secret_access_key  => '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',     # required
    :region                 => 'eu-west-1'                        # optional, defaults to 'us-east-1'
  }

  config.fog_directory  = 'dbhs'                                  # required
  config.fog_public     = true                                    # optional, defaults to true
  #config.fog_host       = 'https://assets.example.com'           # optional, defaults to nil
  #config.fog_public     = false                                  # optional, defaults to true
  config.fog_attributes = { 'Cache-Control' => "max-age=#{365.day.to_i}" }  # optional, defaults to {}
end

