# == Schema Information
#
# Table name: blocs
#
#  id           :bigint           not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  release_date :datetime
#

require 'rails_helper'

RSpec.describe Bloc, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
