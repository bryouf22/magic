class ExtensionSet::RetrieveSetWithMultiVersion
  include Interactor

  def call
    set_ids = []
    ExtensionSet.all.each do |set|
      set.cards.each do |card|
        if set.cards.where(name: card.name).many?
          set_ids << set.id
          break
        end
      end
    end
    context.set_ids
  end
end
