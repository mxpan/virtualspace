CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',
    :aws_access_key_id      => 'AKIAJHJQBIIIPBEGS2SQ', 
    :aws_secret_access_key  => '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',
    :region                 => 'us-west-1', # optional, defaults to 'us-east-1'
  }

  config.fog_directory  = 'vsapp'                     # required
end