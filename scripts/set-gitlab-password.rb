user = User.where(id: 1).first
user.password = '5iveL!fe'
user.password_confirmation = '5iveL!fe'
user.password_expires_at = nil
user.save!