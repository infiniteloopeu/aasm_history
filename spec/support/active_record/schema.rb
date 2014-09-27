def create_ar_schema
  ActiveRecord::Schema.define do
    self.verbose = false

    create_table :dummies, force: true do |t|
      t.string :state
      t.timestamps
    end

    create_table :state_histories, force: true do |t|
      t.string   :state
      t.string   :previous_state
      t.integer  :stateable_id
      t.string   :stateable_type
      t.datetime :created_at
      t.datetime :updated_at
    end

  end
end