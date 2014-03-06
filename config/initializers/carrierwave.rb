CarrierWave.configure do |config|
  config.root = Rails.root.join('tmp') # adding these...
  config.cache_dir = "#{Rails.root}/tmp/uploads" # To let CarrierWave work on heroku
  config.s3_access_policy = :public_read

  config.fog_credentials = {
    :provider               => 'AWS',                        # required
    :aws_access_key_id      => 'AKIAJHJQBIIIPBEGS2SQ',       # required
    :aws_secret_access_key  => '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', # required
    :region                 => '',                  # optional, defaults to 'us-east-1'
    :host                   => '',             # optional, defaults to nil
    :endpoint               => '' # optional, defaults to nil
  }
  config.fog_directory  = 'vsapp'
end