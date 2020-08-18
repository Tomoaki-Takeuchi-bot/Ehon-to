class ImageUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url(*args)
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:

  # 全画像リサイズ登録。アスペクト比継承
  process resize_to_fit: [600, 600]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:

  # シンボルを渡す
  version :thumb do
    process :dynamic_resize_fit
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:

  # 登録可能ホワイトリスト（拡張子）
  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

  # モデル毎にサムネイル値を変える設定。デフォルト(40,40)
  # モデルにて定数THUMBNAIL_SIZEの定義で採用。
  def dynamic_resize_fit
    width, height = model.class::const_defined?("THUMBNAIL_SIZE") ? model.class::THUMBNAIL_SIZE : [40, 40]
    resize_to_fit width, height
  end
end
