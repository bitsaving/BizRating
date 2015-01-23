Role::VALID_ROLES.each do |role|
  Role.create(name: role)
end

STDOUT.puts "admin email"
email = STDIN.gets.chomp

STDOUT.puts "admin password"
password = STDIN.gets.chomp

STDOUT.puts "admin name"
name = STDIN.gets.chomp

admin = User.new(email: email, password: password, password_confirmation: password, first_name: name)
admin.skip_confirmation!
admin.roles = Role.where(name: 'admin')
admin.save
