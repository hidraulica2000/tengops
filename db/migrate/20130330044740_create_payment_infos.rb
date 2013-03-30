class CreatePaymentInfos < ActiveRecord::Migration
  def change
    create_table :payment_infos do |t|
      t.references :market
      t.string :title
      t.text :info
      t.timestamps
    end
  end
end
