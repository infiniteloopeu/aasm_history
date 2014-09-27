module AASM
  class Base
    def has_history
      case AasmHistory::PersistanceDeterminator.determine(@klass)
        when :active_record
          configure 'history_class', 'StateHistory'
          @klass.send :prepend, AasmHistory::Persistance::ActiveRecord
        else
          raise AasmHistory::UnknownPersistanceLayer
      end
    end
  end
end