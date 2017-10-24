# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Cat.create(name: "Fuzzy", birth_date: Time.now.to_date, color: "yellow", sex: "F").save
Cat.create(name: "Fuzzy2", birth_date: Time.now.to_date, color: "blue", sex: "F").save
Cat.create(name: "Fuzzy3", birth_date: Time.now.to_date, color: "red", sex: "M").save
Cat.create(name: "Fuzzy4", birth_date: Time.now.to_date, color: "orange", sex: "M").save
Cat.create(name: "Fuzzy5", birth_date: Time.now.to_date, color: "indigo", sex: "F").save
Cat.create(name: "Fuzzy6", birth_date: Time.now.to_date, color: "yellow", sex: "F").save
Cat.create(name: "Fuzzy7", birth_date: Time.now.to_date, color: "yellow", sex: "M").save
