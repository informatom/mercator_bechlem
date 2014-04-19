module MercatorBechlem
  class Vcategory < Base

    self.table_name = "VCATEGORY"
    self.primary_key = "IDCATEGORY"

    def self.top_category_id
      1452
    end

    def self.ivellio_top_categories
      children(category_id: 145210000) + children(category_id: 145220000)
    end

    def parent_category_id
      cat_id = self.IDCATEGORY.to_s
      cat_id[0..(9 - (cat_id.count("0") + 2))]
    end

    def self.children(category_id: 1452)
      cat_id = category_id.to_s.ljust(9,'0')
      self.find_by_sql [
      "SELECT c.* FROM VCATEGORY c, ITEM2ITEM i2i WHERE i2i.idItem = c.idCategory
      AND i2i.idParItem = ? ORDER by idCategory", cat_id.to_i
      ]
    end

    # --- Instance Methods --- #
    def readonly?  # prevents unintentional changes
      true
    end
  end
end