CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',
    :aws_access_key_id      => 'AKIAJKKFGUUSH4B2ZL5A', 
    :aws_secret_access_key  => '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',
    :region                 => 'us-west-1', # optional, defaults to 'us-east-1'
  }

  #Required for Heroku
  config.cache_dir = "#{Rails.root}/tmp/uploads"
  config.fog_directory  = 'vsapp' # required
end