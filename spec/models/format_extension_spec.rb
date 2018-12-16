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

require 'rails_helper'

RSpec.describe FormatExtension, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
