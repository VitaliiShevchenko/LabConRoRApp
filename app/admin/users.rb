ActiveAdmin.register User do
  permit_params :id, :email, :reset_password_sent_at, :remember_created_at, :created_at, :updated_at

  config.batch_actions = false

  actions :all, except: [ :new, :edit, :view, :create, :update ]

  index do
    column :id
    column :email
    column "Fullname" do |user|
      creator = Creator.find_by(user_id: user.id)
      creator ? "#{creator.first_name} #{creator.last_name} (#{creator.position})" : "Available to create a Creator"
    end
    column :reset_password_sent_at
    column :remember_created_at
    column :updated_at
    column :created_at
    actions
  end

  controller do
    def destroy
      if Creator.find_by(user_id: params[:id])
        flash[:error] = "Error occured while deleting User because Creator was created on its ID"
      else
        User.find(params[:id]).destroy
      end
      redirect_to admin_users_path
    end
  end

  filter :email
end
