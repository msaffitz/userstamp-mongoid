class Post
  include Mongoid::Document
  include Ddb::Userstamp::Stampable
  stampable :stamper_class_name => :person, :deleter => true
  embeds_many :comments
  
  # override destroy to get soft delete like acts_as_paranoid style delete
  # Note: delete_all (used in helper) bypasses this and deletes all rows.
  def destroy
    return false if callback(:before_destroy) == false
    self.deleted_at = DateTime.now
    callback(:after_destroy)
  end
  
end