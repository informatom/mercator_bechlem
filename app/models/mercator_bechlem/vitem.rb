module MercatorBechlem
  class Vitem < Base

    self.table_name = "VITEM"
    self.primary_key = "IDITEM"
    has_many :item2items, :class_name => "Vitem2item", :foreign_key => "IDITEM"

    # --- Instance Methods --- #
    def readonly?  # prevents unintentional changes
      true
    end
  end
end