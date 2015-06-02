module MercatorBechlem
  class Videntifier < Base

    self.table_name = "VIDENTIFIER"
    self.primary_key = "IDITEM"

    # --- Instance Methods --- #
    def readonly?  # prevents unintentional changes
      true
    end
  end
end