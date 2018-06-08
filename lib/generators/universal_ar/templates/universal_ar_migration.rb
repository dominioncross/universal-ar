class UniversalArMigration < ActiveRecord::Migration[5.0]
  def change
    create_table(:platforms) do |t|
      t.string :name
      t.timestamps
    end
    create_table(:scopes) do |t|
      t.references :platform, foreign_key: true
      t.string :name
      t.string :guid, limit: 50
      t.timestamps
    end
    create_table :users do |t|
      t.references :scope, polymorphic: true
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""
      t.string :kind, limit: 30
      t.string :status, limit: 30
      t.string :given_names
      t.string :family_name
      t.string :preferred_name

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      t.string   :unlock_token # Only if unlock strategy is :email or :both
      t.datetime :locked_at


      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    add_index :users, :confirmation_token,   unique: true
    add_index :users, :unlock_token,         unique: true

    ######## ROLES
    create_table(:roles) do |t|
      t.references :scope, polymorphic: true
      t.string :name
      t.string :notes
      t.timestamps
    end
    create_table(:users_roles, id: false) do |t|
      t.references :user
      t.references :role
    end
    add_index(:roles, :name)
    add_index(:roles, [ :name, :scope_type, :scope_id ])
    add_index(:users_roles, [ :user_id, :role_id ])

    #### FUNCTIONS
    create_table :functions do |t|
      t.references :scope, polymorphic: true
      t.string :context
      t.string :code
    end
    create_table(:subject_functions, id: false) do |t|
      t.references :subject, polymorphic: true
      t.references :function
    end
    add_index(:functions, :context)
    add_index(:functions, :code)
    add_index(:subject_functions, [ :subject_id, :subject_type, :function_id ], name: :index_subject_functions)

    ### KEY VALUES
    create_table :key_values do |t|
      t.references  :subject, polymorphic: true
      t.string      :key
      t.string      :value
      t.timestamps
    end
    add_index(:key_values, [:subject_type, :subject_id, :key], name: :index_scope)

    ### KEY VALUE HISTORY
    create_table :key_value_histories do |t|
      t.references  :subject, polymorphic: true
      t.string      :key
      t.string      :was_value
      t.string      :now_value
      t.timestamps
    end
    add_index(:key_value_histories, [:subject_type, :subject_id, :key], name: :index_scope)

    ### COMMENTS
    create_table :comments do |t|
      t.references  :scope, polymorphic: true
      t.references  :subject, polymorphic: true
      t.string      :kind, limit: 30
      t.string      :status, limit: 30
      t.string      :title
      t.string      :content, limit: 5000
      t.references  :user
      t.timestamps
    end

    ### ATTACHMENTS
    create_table :attachments do |t|
      t.references  :scope, polymorphic: true
      t.references  :subject, polymorphic: true
      t.string      :kind, limit: 30
      t.string      :name
      t.string      :notes, limit: 1000
      t.string      :file
      t.references  :user
      t.timestamps
    end

    ### PICTURES
    create_table :pictures do |t|
      t.references  :scope, polymorphic: true
      t.references  :subject, polymorphic: true
      t.string      :kind, limit: 30
      t.string      :name
      t.string      :image
      t.references  :user
      t.timestamps
    end

    ### CONFGURATIONS
    create_table :configurations do |t|
      t.references  :subject, polymorphic: true
      t.string      :class_name
      t.string      :description
      t.string      :key
      t.string      :title
      t.string      :data_type
      t.integer     :sequence
      t.timestamps
    end
    create_table :config_dates do |t|
      t.references  :configuration
      t.references  :subject, polymorphic: true
      t.string      :context
      t.string      :key
      t.date        :value
    end
    create_table :config_strings do |t|
      t.references  :configuration
      t.references  :subject, polymorphic: true
      t.string      :context
      t.string      :key
      t.string      :value
    end
    create_table :config_integers do |t|
      t.references  :configuration
      t.references  :subject, polymorphic: true
      t.string      :context
      t.string      :key
      t.integer      :value
    end
    create_table :config_booleans do |t|
      t.references  :configuration
      t.references  :subject, polymorphic: true
      t.string      :context
      t.string      :key
      t.boolean     :value, default: false
    end
    create_table :reference_numbers do |t|
      t.references :scope, polymorphic: true
      t.references :subject, polymorphic: true
      t.integer :number
    end
    create_table :addresses do |t|
      t.references :scope, polymorphic: true
      t.references :subject, polymorphic: true
      t.string     :kind, limit: 30
      t.string     :line_1, limit: 150
      t.string     :line_2, limit: 150
      t.string     :city, limit: 60
      t.string     :state, limit: 60
      t.string     :country, limit: 3
      t.string     :postal_code, limit: 10
      t.timestamps
    end

    create_table :logs do |t|
      t.references :scope, polymorphic: true
      t.references :subject, polymorphic: true
      t.string :code, limit: 50
      t.string :value, limit: 50
      t.references :user, foreign_key: true
      t.timestamps
    end

  end


end
