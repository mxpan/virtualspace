# encoding: utf-8
class ImageUploadUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  permissions 0777

  # Choose what kind of storage to use for this uploader:
  storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  process :resize_to_fill => [300, 300]
  process :right_orientation
  def right_orientation
    manipulate! do |img|
      img.auto_orient
      img
    end
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :resize_to_fit => [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  
  # def filename
  #     if model.class.exists?(:imageURL => original_filename)
  #       "#{secure_token}.#{file.extension}" if original_filename.present?
  #     else
  #       "#{original_filename}.#{file.extension}"
  #     end
  # end

  # protected
  # def secure_token
  #   var = :"@#{mounted_as}_secure_token"
  #   model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid)
  # end
end