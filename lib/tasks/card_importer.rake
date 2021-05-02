namespace :card_impoter do
  task json_images: :environment do
    MtgJson::ImportImages.call
  end
end
