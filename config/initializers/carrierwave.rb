CarrierWave.configure do |config|
  config.root = Rails.root.join('tmp') # adding these...
  config.cache_dir = 'carrierwave' # ...two lines

  config.fog_credentials = {
    :provider               => 'AWS',                        # required
    :aws_access_key_id      => 'AKIAJHJQBIIIPBEGS2SQ',       # required
    :aws_secret_access_key  => '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', # required
    :region                 => 'us-west-1', # optional, defaults to 'us-east-1'
    :host                   => '',             # optional, defaults to nil
    :endpoint               => '' # optional, defaults to nil
  }

  config.fog_directory  = 'vsapp'                             # required
end