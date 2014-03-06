CarrierWave.configure do |config|

  config.fog_credentials = {
    :provider               => 'AWS',                        # required
    :aws_access_key_id      => 'AKIAJHJQBIIIPBEGS2SQ',       # required
    :aws_secret_access_key  => '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', # required
    :region                 => 'us-west-1', # optional, defaults to 'us-east-1'
    :host                   => 's3-us-west-1.amazonaws.com', # optional, defaults to nil
    :endpoint               => '' # optional, defaults to nil
  }

  config.cache_dir = "#{Rails.root}/tmp/uploads" # To let CarrierWave work on heroku
  config.fog_directory = 'vsapp'
end