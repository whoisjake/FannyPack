require "digest/sha1"
require "Message"
class User < ActiveRecord::Base

  #belongs_to :group
  has_one :usersettings
  has_many :groups

  has_many :invitations
    
  has_many :messages
  has_many :events

  has_and_belongs_to_many :belongs_to,
    :class_name => "Group",
    :foreign_key => "group_id"
  attr_accessor :password
  attr_accessor :verification_password
  #attr_reader :last_activity
  
  validates_uniqueness_of :username
  validates_presence_of :username, :hashed_password
  
  public
  
  def to_s
    "#{self.first_name.capitalize} #{self.last_name.capitalize}"
  end
  
  def self.get_user_by_login(username,password)
    hashed_password = hash_password(password || "")
    find(:first, :conditions => ["username = ? and hashed_password = ?", username, hashed_password])
  end
  
  def get_logged_in_users
   User.find(:all, :conditions => ["last_activity >= DATE_ADD(CURRENT_TIMESTAMP,INTERVAL -15 MINUTE) AND id IN (select user_id from groups_users WHERE group_id IN (select id from groups where user_id = ?))",self.id]);
   # User.find(:all, :conditions => ["last_activity >= DATE_ADD(CURRENT_TIMESTAMP,INTERVAL -15 MINUTE)"]);
  end
  
  def get_all_messages
    Message.find(:all, :conditions => ["id IN (SELECT message_id FROM groups_messages WHERE group_id IN (select group_id from groups_users where user_id = ?)) OR id IN (SELECT id from messages where user_id = ? )ORDER BY posted DESC", self.id,self.id]);
  end

  def get_people_messages
    Message.find(:all, :conditions => ["id IN (SELECT message_id FROM groups_messages WHERE group_id IN (select group_id from groups_users where user_id = ?)) ORDER BY posted DESC", self.id]);
  end
  
  def get_all_events
    Event.find(:all, :conditions => ["id IN (SELECT event_id FROM groups_events WHERE group_id IN (select group_id from groups_users where user_id = ?)) OR id IN (SELECT id FROM events WHERE user_id = ? ) ORDER BY date DESC", self.id, self.id]);
  end
  
  def get_people_events
    Event.find(:all, :conditions => ["id IN (SELECT event_id FROM groups_events WHERE group_id IN (select group_id from groups_users where user_id = ?)) ORDER BY date DESC", self.id]);
  end
  
  def update_activity_timestamp
    self.last_activity = Time.now
  end
  
  def has_access_to_user_id(userid)    
    if Group.find(:all, :conditions => ["id IN (select group_id from groups_users where user_id = ? and group_id IN (SELECT id FROM groups WHERE user_id = ?))",userid,self.id]).size == 1
      true
     else
       false
     end
  end
  
  def before_validation_on_create
    if @password != "" && @password != nil
      self.hashed_password = User.hash_password(self.password)
    end
  end
  
  def before_update
    if @password != "" && @password != nil
      self.hashed_password = User.hash_password(self.password)
    end
  end
  
  def after_save
    @password = nil
  end

  def photo_post=(photo_field)
    self.photo_type = photo_field.content_type.chomp
    self.photo = photo_field.read
  end
  
  
  
  private
  def self.hash_password(password)
    Digest::SHA1.hexdigest(password)
  end
  
end
