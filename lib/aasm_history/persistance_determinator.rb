module AasmHistory
  class UnknownPersistanceLayer < StandardError
    def message
      'Persistance layer is not supported.'
    end
  end

  class PersistanceDeterminator
    def initialize base
      @base = base
    end

    def determine
      hierarchy = @base.ancestors.map {|klass| klass.to_s}

      if hierarchy.include?('ActiveRecord::Base')
        :active_record
      end
    end

    def self.determine base
      new(base).determine
    end

  end
end