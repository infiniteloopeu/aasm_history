if defined? ActiveRecord::Base
  ActiveRecord::Base.include AasmHistory::Ext::ActiveRecord
end