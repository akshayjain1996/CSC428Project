class ApplicationController < ActionController::Base
  # Here we store the classifications by index, when a user starts a new classification session, these
  # are updated.
  
  @classifications = ['c1','c2','c3']
  protect_from_forgery with: :exception

  def self.set_classifications(s)
    @classifications = s
  end

  def self.classifications
    @classifications
  end
end
