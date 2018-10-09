# == Schema Information
#
# Table name: extension_sets
#
#  id            :integer          not null, primary key
#  name          :string
#  release_date  :datetime
#  set_visual    :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  commun_logo   :string
#  uncommun_logo :string
#  rare_logo     :string
#  mythic_logo   :string
#

class ExtensionSet < ApplicationRecord

  has_many :cards

  mount_uploader :set_visual,     CardImageUploader
  mount_uploader :commun_logo,    CardImageUploader
  mount_uploader :uncommun_logo,  CardImageUploader
  mount_uploader :rare_logo,      CardImageUploader
  mount_uploader :mythic_logo,    CardImageUploader
end
