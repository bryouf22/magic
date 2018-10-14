# == Schema Information
#
# Table name: extension_sets
#
#  id            :bigint(8)        not null, primary key
#  name          :string
#  release_date  :datetime
#  set_visual    :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  commun_logo   :string
#  uncommun_logo :string
#  rare_logo     :string
#  mythic_logo   :string
#  slug          :string
#

require 'test_helper'

class ExtensionSetTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
