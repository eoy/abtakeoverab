ActiveAdmin.register Announcement do
  index do
    column :id
    column :title
    column :description
    column :document do |d|
      link_to d.document.filename, d.document.url
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

  controller do
    def permitted_params
      params.permit!
    end
  end
end
