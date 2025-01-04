
ActiveAdmin.register Creator do
  permit_params :first_name,
                :last_name,
                :phone,
                :position
  config.batch_actions = true

  config.action_items.delete_if { |item| item.name == :new }
  config.action_items.delete_if { |item| item.name == :edit }
  config.action_items.delete_if { |item| item.name == :destroy }

  actions :all, except: []

  # action_item :index, only: :index do
  #   if current_admin_user
  #     link_to 'Create Person', send("new_#{activeadminpath}_person_path")
  #   end
  # end

  form title: 'Creator info' do |f|
    div class: 'scroll-y' do
      f.inputs do
        if current_admin_user
          f.input 'first_name'
          f.input 'last_name'
          f.input 'phone'
        end
        #f.input :community_ids, as: :check_boxes, collection: Community.all
      end
    end
    f.actions
  end

  filter :first_name, as: :string
  filter :last_name, as: :string
end