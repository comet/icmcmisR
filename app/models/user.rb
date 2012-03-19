class User < Person
  require 'digest/sha1'
  validates_length_of :username, :within => 3..40
 # validates_length_of :password, :within => 5..40
  validates_presence_of :username, :email #:password :password_confirmation, :salt
  validates_uniqueness_of :username, :email
  #validates_confirmation_of :password
  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => "Invalid email"
  attr_protected :id, :salt
  #has_one :person, :as => :personifiable
  def self.random_string(len)
    #generate a random password consisting of strings and digits
    chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
    newpass = ""
    1.upto(len) { |i| newpass << chars[rand(chars.size-1)] }
    return newpass
  end
  def password=(pass)
    @password=pass
    self.salt = User.random_string(10) if !self.salt?
    self.hashed_password = User.encrypt(@password, self.salt)
    Rails.logger.debug{self.hashed_password.inspect}
    Rails.logger.debug{self.salt.inspect}
  end
  def self.encrypt(pass, salt)
    Digest::SHA1.hexdigest(pass+salt)
  end

  def self.authenticate(login, pass)

    u=find(:first, :conditions=>["username = ?", login])

    return nil if u.nil?
    Rails.logger.debug{u.inspect}
    Rails.logger.debug{User.encrypt(pass, u.salt)}
    return u if User.encrypt(pass, u.salt).eql?(u.hashed_password)

  end

  def send_new_password
    new_pass = User.random_string(10)
    self.password = self.password_confirmation = new_pass
    self.save
    Notifications.deliver_forgot_password(self.email, self.login, new_pass)
  end
  def handle_report(hash)
return User.all
  end
end
