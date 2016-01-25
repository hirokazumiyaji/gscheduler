require 'securerandom'
require 'digest/md5'

class User < ApplicationRecord
  def uuid
    Digest::MD5.hexdigest(SecureRandom.uuid)
  end
end
