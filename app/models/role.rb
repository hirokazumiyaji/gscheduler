class Role < ApplicationRecord
  has_many :members, class_name: :RoleMember, dependent: :destroy

  def member_ids
    members.map{|member| memeber.user_id}
  end
end
