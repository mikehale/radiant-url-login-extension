class FixLoginTokens < ActiveRecord::Migration
  def self.up
    remove_column :users, :login_tokens
    add_column :users, :login_tokens, :string
  end

  def self.down
  end
end
