class AddWhatsappToContactInfo < ActiveRecord::Migration
  def change
    add_column :contact_infos, :whatsapp, :string
  end
end
