class AddTypeToAttachements < ActiveRecord::Migration
  def change
    add_column :attachements, :format, :string, :default => "picture"
  end
end
