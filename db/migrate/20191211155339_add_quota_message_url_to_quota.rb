class AddQuotaMessageUrlToQuota < ActiveRecord::Migration[6.0]
  def change
    add_column :quota, :message, :text
    add_column :quota, :url_redirection, :text
  end
end
