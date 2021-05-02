class CardImageUploader < CarrierWave::Uploader::Base

  storage :file

  def store_dir
    if model.class.name == 'JsonCard' || model.class.name == 'JsonToken'
      "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.json_set&.name.presence&.parameterize || 'default'}"
    elsif model.class.name == 'AlternateFrame'
      "uploads/#{model.card.class.to_s.underscore}/#{mounted_as}/#{model.card.extension_set&.name.presence&.parameterize || 'default'}"
    else
      "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.extension_set&.name.presence&.parameterize || 'default'}"
    end
  end

  def filename
    if model.class.name == 'JsonCard' || model.class.name == 'JsonToken'
      if model.number.present?
        "#{model.face_name.parameterize}-#{model.number}.jpg"
      else
        "#{model.face_name.parameterize}-#{model.uuid[0..4]}.jpg"
      end
    elsif model.class.name == 'AlternateFrame'
      if model.card.number_in_set.present?
        "#{model.card.number_in_set}-#{model.card.name.parameterize}-#{model.card.alternate_frames.where.not(id: model.id).count + 1}.jpg"
      else
        "gid-#{model.gatherer_id}-#{model.name.parameterize}-#{model.card.alternate_frames.where.not(id: model.id).count + 1}.jpg"
      end
    elsif original_filename.present?
      if model.number_in_set.present?
        "#{model.number_in_set}-#{model.name.parameterize}.jpg"
      else
        "gid-#{model.gatherer_id}-#{model.name.parameterize}.jpg"
      end
    end
  end
end
