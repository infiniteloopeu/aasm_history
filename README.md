# AasmHistory

Track and persist AASM state history.

Currently only ActiveRecord is supported.

## Installation

Add this line to your application's Gemfile:

    gem 'aasm_history'

## Usage

Add migration:

    create_table :state_histories do |t|
      t.string   :state
      t.string   :previous_state
      t.integer  :stateable_id
      t.string   :stateable_type
      t.datetime :created_at
      t.datetime :updated_at
    end

It will create state history table - common for all classes.

Inside aasm block insert

    has_history

And that's all!

## Contributing

You are welcome to contribute with Github's Pull Requests!
