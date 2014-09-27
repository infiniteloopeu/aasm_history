[![Build Status](https://travis-ci.org/gogiel/aasm_history.svg?branch=master)](https://travis-ci.org/gogiel/aasm_history)

# AasmHistory

Track and persist AASM state history.

This gem depends on Ruby >= 2.0.0.

## Installation

Add this line to your application's Gemfile:

    gem 'aasm_history'

## Installation

### Active Record

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

Create StateHistory class

    class StateHistory < ActiveRecord::Base
      belongs_to :stateable, polymorphic: true
    end

### Sequel, Mongoid and others

Not supported.

## Usage

Inside `aasm` block call `has_history`.

    aasm do 
        has_history
        # ...
    end
    
You can also call `has_state_history` in your model to create `state_histories` relation.
   
## Example:

### Definition

    class Order
        aasm do
            has_history
            # ...
        end
        
        has_state_history
    end
    
### Usage
    
    #> Order.last.state_histories
     [#<StateHistory id: 2, state: "in_production", previous_state: "new", stateable_id: 2, stateable_type: "Order", created_at: "2014-09-27 22:34:00", updated_at: "2014-09-27 22:34:00">]

## Configuration

In initializer you can set `AasmHistory.enabled_by_default = true` to make all AASM instances have history support by default (in other words no need to call `has_history`).
To make exception call `has_history(false)` in `aasm` block.

## Extending

Gem is highly extendable and configurable.

## Contributing

You are welcome to contribute with Pull Requests and new Issues!
