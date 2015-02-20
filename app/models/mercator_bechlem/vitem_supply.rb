module MercatorBechlem
  class VitemSupply < Base

    self.table_name = "VITEM_SUPPLY"
    self.primary_key = "IDITEM"

    def self.for_category_id(category_id )
      cat_id = category_id.to_s.gsub("0", "")
      self.where(brand: CONFIG[:bechlem_brand]).where("idCategory like ?", "#{cat_id}%").order(artnr: :asc)
    end

    # --- Instance Methods --- #
    def readonly?  # prevents unintentional changes
      true
    end
  end
end
