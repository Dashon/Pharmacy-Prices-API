class JsonWebToken
  def self.encode(payload)
    exp = Time.now.to_i + 18 * 3600

    exp_payload = { :data => payload, :exp => exp }
    JWT.encode(exp_payload, Rails.application.secrets.secret_key_base)
  end

  def self.decode(token)
    return HashWithIndifferentAccess.new(JWT.decode(token, Rails.application.secrets.secret_key_base)[0])
  rescue
    nil
  end
end
