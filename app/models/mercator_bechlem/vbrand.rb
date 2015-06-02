module MercatorBechlem
  class Vbrand < Base

    self.table_name = "VBRAND"
    self.primary_key = "IDBRAND"

    # --- Instance Methods --- #
    def readonly?  # prevents unintentional changes
      true
    end
  end
end