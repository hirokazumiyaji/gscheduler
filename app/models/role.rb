class Role < ApplicationRecord
  has_many :members, class_name: :RoleMember, dependent: :destroy
end
