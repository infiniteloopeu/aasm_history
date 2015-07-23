require 'aasm'

module AasmHistory
  class << self
    attr_accessor :enabled_by_default
  end

  self.enabled_by_default = false

  autoload :PersistanceDeterminator,  'aasm_history/persistance_determinator'
  autoload :UnknownPersistanceLayer,  'aasm_history/persistance_determinator'

  module Persistance
    autoload :ActiveRecord,           'aasm_history/persistance/active_record'
    autoload :ActiveRecordCreator,    'aasm_history/persistance/active_record_creator'
  end

  module Ext
    autoload :ActiveRecord,           'aasm_history/ext/active_record'
  end

end

require 'aasm_history/version'
require 'aasm_history/aasm_ext/base'
require 'aasm_history/aasm_ext/configuration'
require 'aasm_history/load_extensions'