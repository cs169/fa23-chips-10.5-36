# frozen_string_literal: true

class ModelAuthHelper
  def self.init_github_user
    init_user('github', '1', 'github@test.com', 'Github')
  end

  def self.init_google_user
    init_user('google_oauth2', '1', 'google@test.com', 'Google')
  end

  def self.init_user(provider, uid, email, first_name)
    User.create!({
                   provider:   provider,
                   uid:        uid,
                   email:      email,
                   first_name: first_name,
                   last_name:  'Test User',
                   created_at: '2023-11-19 22:20:00',
                   updated_at: '2023-11-19 22:20:00'
                 })
  end

  def self.mock_google_auth
    {
      'uid'      => '2',
      'provider' => 'google_oauth2',
      'info'     => {
        'first_name' => 'Google',
        'last_name'  => 'Test User',
        'email'      => 'google@test.com'
      }
    }
  end

  def self.mock_github_auth
    {
      'uid'      => '2',
      'provider' => 'github',
      'info'     => {
        'email' => 'github@test.com'
      }
    }
  end
end
