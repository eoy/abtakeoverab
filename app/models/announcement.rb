class Announcement < ActiveRecord::Base
    mount_uploader :document, DocumentUploader

    belongs_to :user
    validates_presence_of :title, :document, :on => :create, :message => "can't be blank"

end
