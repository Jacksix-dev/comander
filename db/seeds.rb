# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Table.destroy_all
Food.destroy_all
Order.destroy_all
SelectedFood.destroy_all




  User.create(
    name: Faker::Name.name,
    password:'123456',
    email: 'useradmin@gmail.com',
    role: 'admin'
  )
  User.create(
    name: Faker::Name.name,
    password:'123456',
    email: 'userwaiter1@gmail.com',
    role: 'waiter'
  )

  puts 'Users created.'
  Table.create(
    number: 1,
    customer_number: '',
    total_expended: 0,
    status:'empty')

  Table.create(user_id:2, number: 2, customer_number: '', total_expended: 0,status:'empty')
  Table.create(user_id:2, number: 3, customer_number: '', total_expended: 0,status:'empty')
  Table.create(user_id:2, number: 4, customer_number: '', total_expended: 0,status:'empty')
  Table.create(user_id:2, number: 5, customer_number: '', total_expended: 0,status:'empty')
  Table.create(user_id:2, number: 6, customer_number: '', total_expended: 0,status:'empty')
  Table.create(user_id:2, number: 7, customer_number: '', total_expended: 0,status:'empty')
  Table.create(user_id:2, number: 8, customer_number: '', total_expended: 0,status:'empty')
  Table.create(user_id:2, number: 9, customer_number: '', total_expended: 0,status:'empty')
  Table.create(user_id:2, number: 10, customer_number: '', total_expended: 0,status:'empty')
  Table.create(user_id:2, number: 11, customer_number: '', total_expended: 0,status:'empty')
  Table.create(user_id:2, number: 12, customer_number: '', total_expended: 0,status:'empty')
  Table.create(user_id:2, number: 13, customer_number: '', total_expended: 0,status:'empty')
  Table.create(user_id:2, number: 14, customer_number: '', total_expended: 0,status:'empty')
  Table.create(user_id:2, number: 15, customer_number: '', total_expended: 0,status:'empty')
  Table.create(user_id:2, number: 16, customer_number: '', total_expended: 0,status:'empty')

  puts 'Tables created.'
  Kitchen.create
  puts 'Kitchen created.'
  15.times do
Food.create(
  name: Faker::Food.dish,
  price:Faker::Number.decimal_part(digits: 2),
  type:''
)
  end

  10.times do
    Food.create(
      name: Faker::Beer.brand,
      price:Faker::Number.decimal_part(digits: 2),
      type:''
    )
      end

      puts 'food created.'

5.times do
  Waiter.create(
    name:Faker::Name.name
  )
end

puts 'waiter created.'

Table.all.each do |table|
  Order.create(table_id: table, waiter_id: Waiter.all.first, kitchen: Kitchen.all.first)
end

puts 'Orders created.'


Order.all.each do |order|
  3.times do
    selected_food = SelectedFood.create(order_id: order, food_id: Food.all.sample)
    order.update(total_expended: order.total_expended + selected_food.food.price)
  end
end

puts 'Orders with food created.'
