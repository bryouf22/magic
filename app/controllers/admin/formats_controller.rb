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
    format_card_ids = params['format_card_ids']
    format_extension_set_ids = params['format_extension_set_ids']
    if @format.update_attributes(update_params)
      redirect_to admin_formats_path
    else
      render :edit
    end
  end
  def update_params
    params.require(:format).permit(:name, :card_limit, :card_occurence_limit)
  end

  private

  def update_card_list(format_card_ids)
    @format.
    format_card_ids.each do |card_id|
      if FormatCard.where(format_id: @format, card_id: card_id).none?
        FormatCard.create(format_id: @format, card_id: card_id)
      end
    end
  end

  def update_extension_set_list(format_extension_set_ids)

  end

end
