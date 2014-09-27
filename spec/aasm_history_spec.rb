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

describe 'configuration' do
  context 'default' do
    it 'has enabled_by_default set to false by default' do
      expect(AasmHistory.enabled_by_default).to eq false
      aasm = DummyNotConfigured.aasm
      allow(aasm).to receive(:has_history)
      DummyNotConfigured.aasm {}
      expect(aasm).not_to have_received(:has_history)
    end
  end

  context 'enabled_by_default set to true' do
    after do
      AasmHistory.enabled_by_default = false # change back to default
    end
    it 'adds history to class with aasm' do
      AasmHistory.enabled_by_default = true
      aasm = DummyNotConfigured.aasm
      allow(aasm).to receive(:has_history)
      DummyNotConfigured.aasm {}
      expect(aasm).to have_received(:has_history)
    end

    it 'can be disabled' do
      AasmHistory.enabled_by_default = true
      aasm = DummyNotConfigured.aasm
      DummyNotConfigured.aasm {
        has_history false
      }
      expect(aasm.history_enabled?).to eq false
    end
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