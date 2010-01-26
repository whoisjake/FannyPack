class Message < ActiveRecord::Base
  belongs_to :user
  
  has_and_belongs_to_many :groups,
      :join_table=>"groups_messages"
  #  :class_name => "Group",
  #  :foreign_key => "group_id"


end
