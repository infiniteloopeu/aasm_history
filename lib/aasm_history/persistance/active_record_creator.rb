module AasmHistory
  module Persistance
    class ActiveRecordCreator
      def initialize object, state, previous_state, name
        @object = object
        @state = state
        @previous_state = previous_state
        @name = name
      end

      def create
        klass.create! attributes
      end

      def klass
        @klass ||= AASM::StateMachineStore[@object.class][@name].config.history_class.constantize
      end

      def attributes
        {state: @state, previous_state: @previous_state, stateable: @object}
      end
    end
  end
end
