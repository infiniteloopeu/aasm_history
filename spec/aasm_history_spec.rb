require 'spec_helper'

describe 'AASM History' do
  it 'creates history entry on state change' do
    object = Dummy.create!
    object.a_to_b!
    expect(StateHistory.count).to eq 1
    history = StateHistory.first
    expect(history.stateable).to eq object
    expect(history.state).to eq 'b'
    expect(history.previous_state).to eq 'a'
  end
end