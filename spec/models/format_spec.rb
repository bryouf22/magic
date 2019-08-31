# == Schema Information
#
# Table name: formats
#
#  id                   :bigint           not null, primary key
#  name                 :string
#  card_limit           :integer
#  card_occurence_limit :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

require 'rails_helper'

RSpec.describe Format, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
