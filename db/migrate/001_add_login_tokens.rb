class AddLoginTokens < ActiveRecord::Migration
  def self.up
    add_column :users, :login_tokens, :string, :default => "[]"
  end

  def self.down
    remove_column :users, :login_tokens
  end
end
