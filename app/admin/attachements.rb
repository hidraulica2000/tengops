ActiveAdmin.register Attachement do
  index do
    column :id
    column :new
    column :url
    column :format
    default_actions
  end
end
