module AASM
  class Base
    def has_history
      configure 'history_class', 'StateHistory'
      @klass.send :prepend, AasmHistory::PersistanceDeterminator.determine(@klass)
    end
  end
end