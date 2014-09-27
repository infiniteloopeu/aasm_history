module AasmHistory
  module Persistance
    module ActiveRecord

      def aasm_write_state state
        previous_state = read_attribute(self.class.aasm_column)
        success = super state
        store_aasm_history state, previous_state if success
        success
      end

      private

      def store_aasm_history state, previous_state
        AASM::StateMachine[self.class].config.creator_class.constantize.new(self, state, previous_state).create
      end
    end
  end
end