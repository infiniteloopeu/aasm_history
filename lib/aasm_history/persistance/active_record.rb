module AasmHistory
  module Persistance
    module ActiveRecord

      def aasm_write_state state, name=:default
        previous_state = read_attribute(self.class.aasm(name).attribute_name)
        success = super state
        store_aasm_history state, previous_state, name if success
        success
      end

      private

      def store_aasm_history state, previous_state, name
        AASM::StateMachineStore[self.class][name].config.creator_class.constantize.new(self, state, previous_state, name).create
      end
    end
  end
end
