require 'aasm'

class Dummy < ActiveRecord::Base
  include AASM

  aasm column: 'state' do
    has_history

    state :a, initial: true
    state :b
    state :c

    event :a_to_b do
      transitions from: :a, to: :b
    end
  end
end

class StateHistory < ActiveRecord::Base
  belongs_to :stateable, polymorphic: true
end
