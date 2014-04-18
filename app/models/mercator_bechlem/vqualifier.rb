module MercatorBechlem
  class Vqualifier < Base

    self.table_name = "VQUALIFIER"

    # --- Instance Methods --- #
    def readonly?  # prevents unintentional changes
      true
    end
  end
end