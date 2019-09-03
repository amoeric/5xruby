class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  storage :file

  process resize_to_fill: [200,200]
  
  def default_url(*args)
    "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  end
end