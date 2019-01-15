class Admin::FormatsController < AdminController

  def index
    @formats = Format.all
  end

  def show
  end

  def edit
    @format = Format.find(params[:id])
  end

  def update
    @format = Format.find(params[:id])
    update_card_list update_params[:card_ids]
    update_extension_set_list update_params[:extension_set_ids]
    if @format.update_attributes(update_params)
      redirect_to admin_formats_path
    else
      render :edit
    end
  end
  def update_params
    params.require(:format).permit(:name, :card_limit, :card_occurence_limit, extension_set_ids: [], card_ids: [])
  end

  private

  def update_card_list(format_card_ids)
    (@format.cards.ids - format_card_ids.reject { |id| id.blank? }.collect(&:to_i)).each do |id|
      FormatCard.where(format_id: @format.id, card_id: id).destroy_all
    end
    format_card_ids.each do |card_id|
      if FormatCard.where(format_id: @format.id, card_id: card_id).none?
        FormatCard.create(format_id: @format.id, card_id: card_id)
      end
    end
  end

  def update_extension_set_list(format_extension_set_ids)
    (@format.cards.ids - format_extension_set_ids.reject { |id| id.blank? }.collect(&:to_i)).each do |id|
      FormatExtension.where(format_id: @format.id, extension_set_id: id).destroy_all
    end
    format_extension_set_ids.each do |extension_set_id|
      if FormatExtension.where(format_id: @format.id, extension_set_id: extension_set_id).none?
        FormatExtension.create(format_id: @format.id, extension_set_id: extension_set_id)
      end
    end
  end
end
