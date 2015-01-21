# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Role::VALID_ROLES.each do |role|
  Role.create(name: role)
end
p 'Enter Admin email'
p 'Enter Admin first_name'
p 'Enter Admin second_name'

admin = User.new(first_name: 'Vinayak', last_name: 'Solution',
  password: '123456', password_confirmation: '123456',
  email: 'vinsol2011@gmail.com');
admin.skip_confirmation!
admin.roles = Role.where(name: 'admin')
admin.save(validate: false)
