require_relative 'lib/frack'

# Create users table if it doesn't exist
unless ActiveRecord::Base.connection.table_exists?(:users)
  ActiveRecord::Base.connection.create_table :users do |t|
    t.string :email, null: false
    t.string :password_digest, null: false
    t.timestamps
  end
  
  # Add unique index on email
  ActiveRecord::Base.connection.add_index :users, :email, unique: true
  
  puts "Users table created successfully!"
else
  puts "Users table already exists."
end
