class CardImageUploader < CarrierWave::Uploader::Base

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.extension_set&.name.presence&.parameterize || 'default'}"
  end

  def filename
    if original_filename.present?
      if model.number_in_set.present?
        model.basic_land?
        "#{model.number_in_set}-#{model.name.parameterize}.jpg"
      else
        "gid-#{model.gatherer_id}-#{model.name.parameterize}.jpg"
      end
    end
  end
end
