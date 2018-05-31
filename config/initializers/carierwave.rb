CarrierWave.configure do |config|
  if ENV['AWS_ACCESS_KEY_ID'].present?
    config.fog_provider = 'fog/aws'                        # required
    config.fog_credentials = {
      provider:              'AWS',                        # required
      aws_access_key_id:     ENV['AWS_ACCESS_KEY_ID'],     # required
      aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'], # required
      region:                ENV['S3_REGION'],             # optional, defaults to 'us-east-1'
      host:                  ENV['S3_HOST'],             # optional, defaults to nil
      endpoint:              ENV['S3_ENDPOINT'], # optional, defaults to nil
      path_style: true
    }
    config.fog_public     = true                                        # optional, defaults to true
    config.asset_host = ENV['S3_ASSET_HOST']
    config.fog_directory = ENV['S3_BUCKET_NAME']
    #config.fog_attributes = { cache_control: "public, max-age=#{365.day.to_i}" } # optional, defaults to {}
  elsif ENV['FTP_HOST'].present?
    config.ftp_host = ENV.fetch('FTP_HOST')
    config.ftp_port = 21
    config.ftp_user = ENV.fetch('FTP_USER')
    config.ftp_passwd = ENV.fetch('FTP_PASSWORD')
    config.ftp_folder = ENV.fetch('FTP_PATH')
    config.ftp_url = ENV.fetch('FTP_BASE_URL')
    # config.ftp_passive = false # false by default
    # config.ftp_tls = false # false by default
  end
end
