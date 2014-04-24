module MercatorBechlem
  class Vcategory < Base

    self.table_name = "VCATEGORY"
    self.primary_key = "IDCATEGORY"

    def self.ivellio_top_categories
      Vcategory.find("145210000").children + Vcategory.find("145220000").children
    end

    def parent
      cat_id = self.IDCATEGORY.to_s
      parent_idCategory = cat_id[0..(9 - (cat_id.count("0") + 2))].ljust(9, '0')
      if ["145200000", "145000000"].include? parent_idCategory
        return nil
      else
        return Vcategory.find(parent_idCategory)
      end
    end

    def children
      Vcategory.find_by_sql ["SELECT c.* FROM VCATEGORY c, ITEM2ITEM i2i WHERE i2i.idItem = c.idCategory AND i2i.idParItem = ? ORDER by idCategory", id ]
    end

    def ancestors
      ancestors = self.parents.reverse
    end

    def parents
      [self.parent] + parent.parents.to_a if self.parent
    end

    # --- Instance Methods --- #
    def readonly?  # prevents unintentional changes
      true
    end
  end
end