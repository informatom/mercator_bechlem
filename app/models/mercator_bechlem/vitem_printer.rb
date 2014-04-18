module MercatorBechlem
  class VitemPrinter < Base

    self.table_name = "item_printer_temp"
    self.primary_key = "IDITEM"

    # --- Instance Methods --- #
    def readonly?  # prevents unintentional changes
      true
    end
  end
end