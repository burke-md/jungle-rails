require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js: true do
    # prepare
    before :each do
      @category = Category.create! name: 'Apparel'
  
      10.times do |n|
        @category.products.create!(
          name:  Faker::Hipster.sentence(3),
          description: Faker::Hipster.paragraph(4),
          image: open_asset('apparel1.jpg'),
          quantity: 10,
          price: 64.99
        )
      end
    end

    scenario "when user clicks 'add to cart' button, their cart count goes up by one" do
      visit root_path
      # save_screenshot 'cart_test_1.png'
      
    expect(page).to have_text('My Cart (0)')
    click_on('Add', match: :first)
      
    #confirm
    sleep 5
  
    save_screenshot 'cart_test_2.png'

    expect(page).to have_text('My Cart (1)')
    expect(page).to have_content("Description")
  end
end