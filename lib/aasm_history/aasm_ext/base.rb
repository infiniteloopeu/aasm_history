module AASM
  class Base
    module HistoryMethods
      def aasm_write_state state
        previous_state = read_attribute(self.class.aasm_column)
        success = super state
        store_aasm_history state, previous_state if success
        success
      end

      private

      def store_aasm_history state, previous_state
        AasmHistory::HistoryCreator.new(self, state, previous_state).create
      end
    end

    def has_history options = {}
      configure 'history_class', 'StateHistory'
      @klass.send :prepend, HistoryMethods
    end

  end
end