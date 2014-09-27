module AasmHistory
  class UnknownPersistanceLayer < StandardError
    def message
      'Persistance layer is not supported.'
    end
  end

  class PersistanceDeterminator
    def self.determine(base)
      hierarchy = base.ancestors.map {|klass| klass.to_s}

      if hierarchy.include?('ActiveRecord::Base')
        AasmHistory::Persistance::ActiveRecord
      else
        raise UnknownPersistanceLayer
      end
    end
  end
end