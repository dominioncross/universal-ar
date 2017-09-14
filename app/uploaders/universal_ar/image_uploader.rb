module UniversalAr
  class ImageUploader < CarrierWave::Uploader::Base

    include CarrierWave::RMagick

    storage :fog

    # Override the directory where uploaded files will be stored.
    # This is a sensible default for uploaders that are meant to be mounted:
    def store_dir
      path = []
      if !model.subject.nil?
        path.push(model.subject.class.name.demodulize.to_s.underscore)
        path.push(model.subject.id.to_s)
      end
      path.push(model.class.name.demodulize.to_s.underscore)
      path.push(model.id)
      return path.join('/')
    end

    # Create different versions of your uploaded files:
    version :icon do
      process :resize_to_fit => [24, 24]
    end
    version :thumb do
      process :resize_to_fit => [48,48]
    end
    version :small do
      process :resize_to_fit => [90,90]
    end
    version :medium do
      process :resize_to_fit => [300,300]
    end
    version :large do
      process :resize_to_fit => [600,600]
    end
    
  end
end