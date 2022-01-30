class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def create_reset_digest
    self.reset_token = ApplicationRecord.new_token
    update_columns(reset_digest: ApplicationRecord.digest(reset_token), reset_sent_at: Time.zone.now)
  end

  def ApplicationRecord.new_token
    SecureRandom.urlsafe_base64
  end

  def ApplicationRecord.digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end
end
