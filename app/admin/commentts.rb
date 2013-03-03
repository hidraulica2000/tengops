ActiveAdmin.register Commentt do
  index do
    column :id
    column :new
    column :user
    column :content
    column :created_at
    default_actions
  end
end
