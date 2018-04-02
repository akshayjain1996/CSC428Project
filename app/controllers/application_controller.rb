class ApplicationController < ActionController::Base
  @classifications = ['c1','c2','c3']
  protect_from_forgery with: :exception

  def self.set_classifications(s)
    @classifications = s
  end

  def self.classifications
    @classifications
  end
end
