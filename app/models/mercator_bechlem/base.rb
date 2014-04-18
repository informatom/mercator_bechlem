module MercatorBechlem
  class Base < ActiveRecord::Base

    establish_connection :bechlem
    self.abstract_class = true
  end
end