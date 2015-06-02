module MercatorBechlem
  class Vdescriptor < Base

    self.table_name = "VDESCRIPTOR"
    self.primary_key = "IDITEM"

    # --- Instance Methods --- #
    def readonly?  # prevents unintentional changes
      true
    end
  end
end