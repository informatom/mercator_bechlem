module MercatorBechlem
  class Vqualifier < Base

    self.table_name = "vqualifier"

    # --- Instance Methods --- #
    def readonly?  # prevents unintentional changes
      true
    end
  end
end