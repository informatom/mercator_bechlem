module MercatorBechlem
  class Vpicture < Base

    self.table_name = "vpicture"
    self.primary_key = "IDITEM"

    # --- Instance Methods --- #
    def readonly?  # prevents unintentional changes
      true
    end
  end
end