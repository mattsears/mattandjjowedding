class Rsvp < ApplicationRecord
  validates :email, :email_format => { :message => 'is not looking good' }

end
