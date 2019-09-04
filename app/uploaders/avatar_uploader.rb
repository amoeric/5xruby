class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  if Rails.env.production?      #production的時候改為上傳至sw3
    storage :fog
  else
    storage :file
  end

  process resize_to_fill: [200,200]
  
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url(*args)
    "https://5x-pet-collage.s3-ap-northeast-1.amazonaws.com/seed/avatar/285645-128.png"
  end
end