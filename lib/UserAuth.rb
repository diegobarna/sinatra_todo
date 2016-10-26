class UserAuth
  def self.valid?(user, password)
    valid_users = YAML::load( File.open( './secrets/secrets' ) )
    valid_users[user] == password
  end
end