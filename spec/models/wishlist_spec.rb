# == Schema Information
#
# Table name: wishlists
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#  name       :string
#  slug       :string           not null
#

require 'rails_helper'

RSpec.describe Wishlist, :type => :model do
  it "should not create wishlist without user or name" do
    User.create(email: 'test@test', password: 'password')

    Wishlist.create
    expect(Wishlist.first).to eq(nil)

    Wishlist.create(user_id: User.first.id)
    expect(Wishlist.first).to eq(nil)

    Wishlist.create(name: "ma liste")
    expect(Wishlist.first).to eq(nil)

    Wishlist.create(user_id: User.first.id, name: "ma liste")
    expect(Wishlist.first).not_to eq(nil)

    Wishlist.create(user_id: User.first.id, name: "ma liste")
    expect(Wishlist.all.count).to eq(1)

    Wishlist.create(user_id: User.first.id, name: "Ma 2e liste")
    expect(Wishlist.all.count).to eq(2)
  end
end
