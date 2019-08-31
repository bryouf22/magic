# == Schema Information
#
# Table name: blocs
#
#  id         :bigint           not null, primary key
#  bloc_order :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Bloc < ApplicationRecord

  has_many :extension_sets

  def name
    extension_sets.order('extension_sets.order ASC').collect(&:name).join(' / ').presence || 'Nouveau bloc'
  end
end
