# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(email: 'jan@kowalski.com', password: 'password', firstname: 'Jan', lastname: 'Kowalski', admin: true)
User.create!(email: 'adam@nowak.pl', password: 'password', firstname: 'Adam', lastname: 'Nowak')
User.create!(email: 'foo@bar.com', password: 'password', firstname: 'Foo', lastname: 'Bar')
User.create!(email: 'foo1@bar.com', password: 'password', firstname: 'Foo1', lastname: 'Bar1')
User.create!(email: 'foo2@bar.com', password: 'password', firstname: 'Foo2', lastname: 'Bar2')
User.create!(email: 'foo3@bar.com', password: 'password', firstname: 'Foo3', lastname: 'Bar3')

Category.create!(name: 'Movies')

Product.create!(title: 'Movie One', description: 'Here is a nice description for this movie', price: '9.99', category_id: 1, user_id: 1)
Product.create!(title: 'Movie Two', description: 'Here is a nice description for this movie', price: '9.99', category_id: 1, user_id: 1)
Product.create!(title: 'Movie Three', description: 'Here is a nice description for this movie', price: '9.99', category_id: 1, user_id: 1)
Product.create!(title: 'Movie Four', description: 'Here is a nice description for this movie', price: '9.99', category_id: 1, user_id: 2)
Product.create!(title: 'Movie Five', description: 'Here is a nice description for this movie', price: '9.99', category_id: 1, user_id: 2)
Product.create!(title: 'Movie Six', description: 'Here is a nice description for this movie', price: '9.99', category_id: 1, user_id: 3)

Review.create!(content: 'This is a content one.', rating: 5, product_id: 1, user_id: 1)
Review.create!(content: 'This is a content two.', rating: 2, product_id: 1, user_id: 1)
Review.create!(content: 'This is a content three.', rating: 3, product_id: 2, user_id: 2)
Review.create!(content: 'This is a content four.', rating: 1, product_id: 2, user_id: 2)
Review.create!(content: 'This is a content five.', rating: 4, product_id: 2, user_id: 2)
Review.create!(content: 'This is a content six.', rating: 2, product_id: 3, user_id: 1)
Review.create!(content: 'This is a content seven.', rating: 5, product_id: 3, user_id: 2)
Review.create!(content: 'This is a content eight.', rating: 3, product_id: 3, user_id: 1)
