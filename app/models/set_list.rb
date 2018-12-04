# == Schema Information
#
# Table name: set_lists
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class SetList < ApplicationRecord
  has_many :extension_sets
end
