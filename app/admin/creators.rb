ActiveAdmin.register Creator do
  permit_params :user_id,
                :first_name,
                :last_name,
                :phone,
                :position,
                :order_description

  config.batch_actions = true

  form title: 'Creator info' do |f|
    div class: 'scroll-y' do
      f.inputs do
        if current_admin_user
          f.input :user_id,  as: :hidden, input_html: { value: User.last.id }
          f.input :user_id if f.object.persisted?
          f.input 'first_name'
          f.input 'last_name'
          f.input 'phone'
          f.input 'position'
          f.input 'order_description'
        end
      end
    end
    f.actions
  end

  controller do
    def creator_params
      params.require(:creator).permit(:user_id, :position, :first_name, :last_name, :phone, :order_description)
    end
    def create
      @creator = Creator.new(creator_params)

      if @creator.save
        flash[:notice] = "Creator created successfully!"
        redirect_to admin_creators_path
      else
        flash[:error] = "Error:  #{@creator.errors.full_messages.join(", ")}. " \
          "To start, the User must register. You must send them a registration request. After that, you can create a Creator. " \
          "Check Users!"
        render :new
      end
    end

    def update
      begin
        Creator.update(creator_params)
        flash[:notice] = "Creator updated successfully!"
        redirect_to admin_creators_path
      rescue ActiveRecord::RecordInvalid => e
        flash[:error] = "Error: #{e}. "
        render :new
      end
    end
  end

  filter :first_name, as: :string
  filter :last_name, as: :string
end
