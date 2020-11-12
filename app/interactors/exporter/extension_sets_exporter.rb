class Exporter::ExtensionSetsExporter
  include Interactor

  def call
    export_path = context.export_path.presence || "#{Rails.root}/export_sets.xml"

    builder = Nokogiri::XML::Builder.new do |xml|
      xml.root do
        # TODO EXPORTER LES FORMATS (MODERN LEGACY ETC)
        SetList.all.each do |set_list|
          xml.set_list(name: set_list.name)
        end
        Bloc.all.each do |bloc|
          xml.bloc(name: bloc.name)
        end
        ExtensionSet.all.find_each do |extension_set|
          xml.set(
            name: extension_set.name,
            release_date: extension_set.release_date.to_date.to_s, # ex "2017-01-20"
            set_type: extension_set.set_type,
            bloc: extension_set.bloc&.name,
            set_list: extension_set.set_list&.name,
            code: extension_set.code,
            card_count: extension_set.card_count,
            new_card_count: extension_set.new_card_count,
            reprint_count: extension_set.reprint_count
          ) do |set|
            # extension_set.cards.each do |card|
            #   next if card.alternative?

            #   if card.has_alternative?
            #     xml.card(name: card.name.split(' / ').first) do
            #       xml.alternative_card(name: card.alternative_card.name)
            #     end
            #   else
            #     xml.card(name: card.name)
            #   end
            # end
          end
        end
      end
    end
    File.open(export_path, 'w+') do |file|
      file.write builder.to_xml
    end
  end
end
