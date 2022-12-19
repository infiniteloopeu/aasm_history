module AASM
  class Base
    def has_history enabled = true
      @options[:history_enabled] = enabled
      if enabled
        case AasmHistory::PersistanceDeterminator.determine(@klass)
          when :active_record
            configure :history_class, 'StateHistory'
            configure :creator_class, 'AasmHistory::Persistance::ActiveRecordCreator'
            @klass.send :prepend, AasmHistory::Persistance::ActiveRecord
          else
            raise AasmHistory::UnknownPersistanceLayer
        end
      end
    end

    def history_enabled?
      @options[:history_enabled]
    end
  end

  module ClassMethods
    def aasm(*args, &block)
      if args[0].is_a?(Symbol) || args[0].is_a?(String)
        # using custom name
        state_machine_name = args[0].to_sym
        options = args[1] || {}
      else
        # using the default state_machine_name
        state_machine_name = :default
        options = args[0] || {}
      end

      AASM::StateMachineStore.fetch(self, true).register(state_machine_name, AASM::StateMachine.new(state_machine_name))

      # use a default despite the DSL configuration default.
      # this is because configuration hasn't been setup for the AASM class but we are accessing a DSL option already for the class.
      aasm_klass = options[:with_klass] || AASM::Base

      raise ArgumentError, "The class #{aasm_klass} must inherit from AASM::Base!" unless aasm_klass.ancestors.include?(AASM::Base)

      @aasm ||= Concurrent::Map.new
      if @aasm[state_machine_name]
        # make sure to use provided options
        options.each do |key, value|
          @aasm[state_machine_name].state_machine.config.send("#{key}=", value)
        end
      else
        # create a new base
        @aasm[state_machine_name] = aasm_klass.new(
          self,
          state_machine_name,
          AASM::StateMachineStore.fetch(self, true).machine(state_machine_name),
          options
        )
      end
      if block # new DSL
        @aasm[state_machine_name].instance_eval(&block)
        if AasmHistory.enabled_by_default && @aasm[state_machine_name].history_enabled? == nil
          @aasm[state_machine_name].has_history
        end
      end
      @aasm[state_machine_name]
    end
  end
end
