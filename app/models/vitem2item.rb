module MercatorBechlem
  class Vitem2item < Base

    self.table_name = "item2item_temp"
    self.primary_key = "IDITEM"

    belongs_to :item, :class_name => "Vitem", :primary_key => "IDITEM"
    belongs_to :part_item, :class_name => "Vitem", :primary_key => "IDPARTITEM"

    # --- Instance Methods --- #
    def readonly?  # prevents unintentional changes
      true
    end
end
end