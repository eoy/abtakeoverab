ActiveAdmin.register Announcement do
  config.batch_actions = true
  index do
    column :title
    column :description
    column :document do |d|
      link_to image_tag(d.document.thumb.url), d.document.url
    end
    default_actions
  end

  form do |f|
    f.inputs "Details" do
      f.input :title
    end
    f.inputs "Content" do
      f.input :description
      f.input :document, :as => :file
    end
    f.actions
  end

  member_action :delete, :method => :get do
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_to "/admin/commments"
  end

  filter :title

  controller do
    def permitted_params
      params.permit!
    end
  end
end
