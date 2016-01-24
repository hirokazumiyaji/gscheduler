class RoleMember < ApplicationRecord
  belongs_to :role
  belongs_to :user
end
