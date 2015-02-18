#FIXME_AB: Print some text for user what is being done here.
## FIXED
STDOUT.puts "Adding admin and user role to database"

Role::VALID_NAMES.each do |role|
  Role.create(name: role)
end


#FIXME_AB: Please display intuitive messages for user. admin email doesn't tell any thing to user. It should say something like: "Please enter admin email:" Similarly for other places
## FIXED
STDOUT.puts "Please enter admin email:"
email = STDIN.gets.chomp

STDOUT.puts "Please enter admin password:"
password = STDIN.gets.chomp

STDOUT.puts "Please enter admin name:"
name = STDIN.gets.chomp

admin = User.new(email: email, password: password, password_confirmation: password, name: name)
admin.skip_confirmation!
admin.roles = Role.where(name: 'admin')

if admin.save
  STDOUT.puts "Admin account created successfully"
else
  STDOUT.puts "Admin account not created, please try again"
end

#FIXME_AB: You should also tell user that account is created. If not created then tell him about errors and try again.
## FIXED