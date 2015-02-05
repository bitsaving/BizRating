#FIXME_AB: Print some text for user what is being done here.
Role::VALID_NAMES.each do |role|
  Role.create(name: role)
end

#FIXME_AB: Please display intuitive messages for user. admin email doesn't tell any thing to user. It should say something like: "Please enter admin email:" Similarly for other places
STDOUT.puts "admin email"
email = STDIN.gets.chomp

STDOUT.puts "admin password"
password = STDIN.gets.chomp

STDOUT.puts "admin name"
name = STDIN.gets.chomp

admin = User.new(email: email, password: password, password_confirmation: password, name: name)
admin.skip_confirmation!
admin.roles = Role.where(name: 'admin')
admin.save

#FIXME_AB: You should also tell user that account is created. If not created then tell him about errors and try again.