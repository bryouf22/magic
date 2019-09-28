namespace :backup do
  desc "export users in xml file (user with collection wish list and decks)"
  task users: :environment do
    base_path = Rails.env.production? ? "/home/deploy/backups/" : "#{Rails.root}/../"
    Exporter::ExportUsers.call(export_path: "#{base_path}users_#{Date.current.to_s}.xml")
  end
end
