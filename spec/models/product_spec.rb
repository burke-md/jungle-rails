require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it "is valid with correct arrtibutes" do
      categoy = Category.new(name: 'Apparel')
      product = Product.new(
        name:  'Best pants ever',
        description: "Just incredible. You wont belive it",
        category: category,
        quantity: 5,
        price: 50.00
      )
      expect(product).to be_valid
    end
     # validates :name, prescence: true
     it "is not valid without a name" do
      category = Category.new(name: 'Apparel')
      product = Product.new(
        name: nil,
        description: "Just incredible. You wont belive it",
        category: category,
        quantity: 10,
        price: 64.99
      )
      expect(product).to_not be_valid
    end

    # validates :price, presence: true
    it "is not valid without a price" do
      category = Category.new(name: 'Apparel')
      product = Product.new(
        name:  'Best pants ever',
        description: "Just incredible. You wont belive it",
        category: category,
        quantity: 10,
        price: nil
      )
      expect(product).to_not be_valid
    end

    #validates :quantity, presence: true
    it "is not valid without a quantity" do
      category = Category.new(name: 'Apparel')
      product = Product.new(
        name:  'Best pants ever',
        description: "Just incredible. You wont belive it",
        category: category,
        quantity: nil,
        price: 64.99
      )
      expect(product).to_not be_valid
    end

    # validates :category, precense :true
    it "is not valid without a category" do
      category = Category.new(name: 'Apparel')
      product = Product.new(
        name:  'Best pants ever',
        description: "Just incredible. You wont belive it",
        category: nil,
        quantity: 10,
        price: 64.99
      )
      expect(product).to_not be_valid
    end

end
end
