class ForoMigration < ActiveRecord::Migration
  def self.up
    create_table :follows, :force => true do |t|
      t.references :followable, :null => false
      t.references :follower,   :null => false
      t.boolean :blocked, :default => false, :null => false
      t.timestamps
    end

    add_index :follows, :follower_id,   :name => "fk_follows"
    add_index :follows, :followable_id, :name => "fk_followables"
  end

  def self.down
    drop_table :follows
  end
end
