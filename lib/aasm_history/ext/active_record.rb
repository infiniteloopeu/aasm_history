module AasmHistory
  module Ext
    module ActiveRecord
      def self.included base
        base.extend ClassMethods
      end

      module ClassMethods
        def has_state_history
          has_many :state_histories, as: :stateable
        end
      end
    end
  end
end