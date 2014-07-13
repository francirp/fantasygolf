ActiveAdmin.register Tournament do

  config.sort_order = "start_date_desc"

  permit_params :name, :start_date, :url

  index do
    selectable_column
    keys = Tournament.new.attributes.keys
    keys = keys - ["created_at", "updated_at"]
    keys.each do |attr|
      column attr
    end
    actions
  end

end
