if defined? ActiveRecord::Base
  ActiveRecord::Base.send :include, AasmHistory::Ext::ActiveRecord
end