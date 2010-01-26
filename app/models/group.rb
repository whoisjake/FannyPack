class Group < ActiveRecord::Base
  belongs_to :user
  #has_many :members, class_name => "User", foreign_key => "member_id"
  has_and_belongs_to_many :members,
    :class_name => "User",
    :foreign_key => "user_id"
  
  has_and_belongs_to_many :messages,
    :join_table=>"groups_messages"
  has_and_belongs_to_many :events,
    :join_table=>"groups_events"
  
  has_many :invitations
end
