module MercatorBechlem
  class Vdescriptor < Base

    self.table_name = "vdescriptor"
    self.primary_key = "IDITEM"

    # --- Instance Methods --- #
    def readonly?  # prevents unintentional changes
      true
    end
  end
end