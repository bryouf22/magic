# == Schema Information
#
# Table name: blocs
#
#  id         :bigint(8)        not null, primary key
#  bloc_order :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Bloc, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
