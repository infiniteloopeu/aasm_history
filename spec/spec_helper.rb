require 'aasm_history'
require 'active_record'

Dir[File.join(File.dirname(__FILE__), "support/**/*.rb")].each { |f| require_relative f }

ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"
create_ar_schema