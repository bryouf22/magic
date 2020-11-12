# == Schema Information
#
# Table name: blocs
#
#  id           :bigint           not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  release_date :datetime
#

class Bloc < ApplicationRecord
  has_many :extension_sets

  before_save :set_sate

  def name
    extension_sets.order('extension_sets.release_date ASC').collect(&:name).join(' / ').presence || 'Nouveau bloc'
  end

  def set_date
    self[:release_date] = extension_sets.order('release_date ASC').first.release_date if extension_sets.any?
  end
end
