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
    def aasm(options={}, &block)
      @aasm ||= AASM::Base.new(self, options)
      if block
        @aasm.instance_eval(&block)
        if AasmHistory.enabled_by_default && @aasm.history_enabled? == nil
          @aasm.has_history
        end
      end
      @aasm
    end
  end
end