ActiveAdmin.register Attachement do
  index do
    column :id
    column :new
    column :url
    column :type
    default_actions
  end
end
