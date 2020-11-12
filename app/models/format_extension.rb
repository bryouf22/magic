# == Schema Information
#
# Table name: format_extensions
#
#  id               :bigint           not null, primary key
#  format_id        :bigint
#  extension_set_id :bigint
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class FormatExtension < ApplicationRecord
  belongs_to :format
  belongs_to :extension_set
end
