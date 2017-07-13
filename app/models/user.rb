class User < ApplicationRecord

  has_secure_password
  #secure password is a built in rails method that provides use authentication features
  #for the model its called in
  #1. it will automatically add a presence validator for the passsword field
  # 2. it will create two virtual fields: password and password confirmation
  # 3. when given a password, it will generate a salt. the it will hash the hash salt and password combo
  # and password combo, store the result in the password_digest column using `bcrypt`

  #4. if you skip the password confirmation field, then it wont give you a validation error or that,
  #but if you provide it, it will validate that the `password` and `password_confirmation` are the same.

  #5. the user instance gets the `authenticate` method which will allow us to verify if a user entered
  # a correct passwor.d it returns aflse if the password is incorrect and

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, format: VALID_EMAIL_REGEX

  validates :first_name, :last_name, presence: true

  def full_name
    "#{first_name} #{last_name}"
  end

end
