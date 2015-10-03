class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def generate_sig(endpoint, params, secret)
    sig = endpoint
    params.sort.map do |key, val|
      sig += '|%s=%s' % [key, val]
    end
    digest = OpenSSL::Digest::Digest.new('sha256')
    return OpenSSL::HMAC.hexdigest(digest, secret, sig)
  end
end
