task :seed_admin => :environment do
  Role::VALID_ROLES.each do |role|
    Role.create(name: role)
  end
  input = 'vinsol2011@gmail.com'
  STDOUT.puts "admin email"
  email = STDIN.gets.chomp

  STDOUT.puts "admin password"
  password = STDIN.gets.chomp

  STDOUT.puts "admin first name"
  first_name = STDIN.gets.chomp

  admin = User.new(first_name: first_name, email: email, password: password, password_confirmation: password)
  admin.skip_confirmation!
  admin.roles = Role.where(name: 'admin')
  admin.save(validate: false)
end
