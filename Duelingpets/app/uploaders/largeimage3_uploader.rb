class Largeimage3Uploader < CarrierWave::Uploader::Base
   include CarrierWave::RMagick
   storage :file

   # Override the directory where uploaded files will be stored.
   # This is a sensible default for uploaders that are meant to be mounted:
   def store_dir
      #Solution to one issue
      "Resources/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
   end

   def cache_dir
      "Resources/uploads/tmp/"
   end

   version :thumb do
      process :resize_to_fit => [175, 175]
   end

   def extension_white_list
      %w(jpg jpeg gif png)
   end
end
