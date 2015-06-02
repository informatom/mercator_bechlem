module MercatorBechlem
  class VitemMedia < Base

    self.table_name = "VITEM_MEDIA"
    self.primary_key = "IDITEM"

    # --- Instance Methods --- #
    def readonly?  # prevents unintentional changes
      true
    end
  end
end