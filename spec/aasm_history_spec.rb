require 'spec_helper'

describe 'determining persistance layer' do
  class NoPersistence
    include AASM
  end

  it 'fails if persistance layer is unknown' do
    expect {
      NoPersistence.aasm do
        has_history
      end
    }.to raise_exception AasmHistory::UnknownPersistanceLayer
  end
end

describe 'saving history' do
  describe 'active record' do
    subject! do
      object = Dummy.create!
      object.a_to_b!
      object
    end

    it 'creates history entry on state change' do
      expect(StateHistory.count).to eq 1
      history = StateHistory.first
      expect(history.stateable).to eq subject
      expect(history.state).to eq 'b'
      expect(history.previous_state).to eq 'a'
    end

    it 'is possible to acess history using relation from helper' do
      expect(subject.state_histories.count).to eq 1
    end
  end
end