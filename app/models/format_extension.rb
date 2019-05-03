# == Schema Information
#
# Table name: format_extensions
#
#  id               :bigint(8)        not null, primary key
#  format_id        :bigint(8)
#  extension_set_id :bigint(8)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class FormatExtension < ApplicationRecord

  belongs_to :format
  belongs_to :extension_set
end
