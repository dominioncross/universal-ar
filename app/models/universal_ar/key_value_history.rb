class UniversalAr::KeyValueHistory < ApplicationRecord
  self.table_name = 'key_value_histories'
  include UniversalAr::Concerns::Polymorphic
  
end
