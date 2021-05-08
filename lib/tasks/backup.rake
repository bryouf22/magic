namespace :backup do
  # cron save
  # 35 21 * * * cd /home/deploy/magic/current && bundle exec rake backup:users RAILS_ENV="production"
  # 35 21 * * * pg_dump -Udeploy magic > /home/deploy/backups/$(date +"%a")sql
  # 0 22 * * * zip -r /home/deploy/backups/public_card.zip /home/deploy/magic/shared/public/uploads/card/

  # scp deploy@lordyawgmoth.com:/home/deploy/backups/jeu.sql .
  # scp deploy@lordyawgmoth.com:/home/deploy/backups/public_card.zip .
  # scp deploy@lordyawgmoth.com:/mnt/vdb/json_card.zip .
  # scp deploy@lordyawgmoth.com:/mnt/vdb/json_token.zip .

  desc "export users in xml file (user with collection wish list and decks)"
  task users: :environment do
    base_path = Rails.env.production? ? "/home/deploy/backups/" : "#{Rails.root}/../"
    Exporter::ExportUsers.call(export_path: "#{base_path}users_#{Date.current.to_s}.xml")
  end
end
