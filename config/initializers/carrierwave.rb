if Rails.env.production?
  CarrierWave.configure do |config|
    config.storage = :fog
    config.fog_provider = 'fog/aws'
    config.fog_directory = 'ehon-to.image'
    config.fog_credentials = {
      # Amazon S3用の設定
      provider: 'AWS',
      region: 'ap-northeast-1',
      aws_access_key_id: Rails.application.credentials.aws[:access_key_id],
      aws_secret_access_key:
        Rails.application.credentials.aws[:secret_access_key]
    }
    # <TODO 追加機能検討要素 https化>
    # CloudFront設定
    config.asset_host = 'http://image.ehon-to.net'
  end
end

# 日本語ファイル名の設定
# @see https://github.com/carrierwaveuploader/carrierwave#filenames-and-unicode-chars
CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/