module MercatorBechlem
  class VresellerItem < Base

    self.table_name = "vreselleritem"

    # --- Instance Methods --- #
    def readonly?  # prevents unintentional changes
      true
    end
  end
end