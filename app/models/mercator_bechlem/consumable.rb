module MercatorBechlem
  class Consumable < ActiveRecord::Base

    hobo_model # Don't put anything above this

    # --- Instance Methods --- #
    def readonly?  # prevents unintentional changes
      true
    end
  end
end