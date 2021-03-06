require 'rails_helper'

RSpec.feature "Visitor clicks on a product in home page", type: :feature, js: true do
#prepare
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

  scenario "They see the product page" do
    visit root_path
    first('.product-image').click

    # confirm
    sleep 5
    save_screenshot

    expect(page).to have_css 'article.product-detail'
    expect(page).to have_content("Description")
    expect(page).to have_content("Quantity")
  end

end