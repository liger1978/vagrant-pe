user = User.where(id: 1).first
token = user.authentication_token
print "#{token}\n"

