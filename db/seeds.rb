# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'faker'
require 'csv'

Product.destroy_all
Category.destroy_all

csv_file = Rails.root.join('db/products.csv')
csv_data = File.read(csv_file)

products = CSV.parse(csv_data, headers: true)

products.each do |product|
    print product
    new_category = Category.find_or_create_by(name: product[4])
    new_category.save
    new_product = new_category.products.build(title: product[0], description: product[3], price: product[1], stock_quantity: product[3])
#    product = Product.new(title: Faker::Name.first_name, price: Faker::Commerce.price, stock_quantity: Faker::Number.number(digits: 2))
    new_product.save
end
