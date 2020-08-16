# == Schema Information
#
# Table name: alternate_frames
#
#  id         :bigint           not null, primary key
#  card_id    :integer          not null
#  image      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class AlternateFrame < ApplicationRecord

  belongs_to :card

  mount_uploader :image, CardImageUploader

end
