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

require 'rails_helper'

RSpec.describe FormatExtension, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
