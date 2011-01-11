class Media
  include Mongoid::Document
  include Mongoid::Timestamps
  
  # Mongoid doesn't support the ActiveModel::Observer pattern
  set_callback :update, :before, :expire_caches
  
  set_callback :create, :after, :on_image_upload
  
  references_many :articles, :stored_as => :array, :inverse_of => :medias
  
  field :description, :type => String
  field :date, :type => DateTime
  field :author, :type => String
  field :file_uid, :type => String
  
  attachment_accessor :file  
  
  validates_presence_of :file
  
  private
  def expire_caches
    Rails.cache.delete("views/media-image-tag-288x>-#{self.id}") unless self.changes.dup.delete_if{|k,v| k == 'updated_at'}.blank?
  end
  
  def on_image_upload
    Delayed::Job.enqueue OnImageUpload.new(self)
  end
  
end
