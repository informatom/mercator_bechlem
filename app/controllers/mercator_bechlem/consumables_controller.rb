module MercatorBechlem
  class ConsumablesController < ApplicationController

    hobo_model_controller

    index_action :products do
      printer = params[:id]

      @products = MercatorBechlem::Vitem2item.where(IDITEM: printer )
      printer_alternative_numbers = @products.collect { |product| "#{product.ARTNR.gsub("\s", '')}" }.uniq
      @this = @products = Inventory.where(alternative_number: printer_alternative_numbers).*.product
                          # gsub removes whitespace characters, compact removes nil elements
    end

    index_action :printer do
      printerseries = params[:id]

      if printerseries.nil? ||printerseries == "All"
        @printer_series = MercatorBechlem::VitemPrinter.where(brand: "HP").where.not(printerseries: nil).order(PRINTERSERIES: :asc)
        @printer_series_names = @printer_series.*.PRINTERSERIES.uniq
        @printers = MercatorBechlem::VitemPrinter.where(brand: "HP").select("CATEGORY, BRAND, DESCRIPTION, IDITEM").order(DESCRIPTION: :asc)
      else
        @printers = MercatorBechlem::VitemPrinter.where(brand: "HP").select("CATEGORY, BRAND, DESCRIPTION, IDITEM")
                                                 .where(printerseries: printerseries).order(DESCRIPTION: :asc)
      end
    end

    index_action :category do
      category_id = params[:id]
      cat_id = category_id.to_s.ljust(9,'0')

      if category_id.to_i == MercatorBechlem::Vcategory.top_category_id
        @material_categories = MercatorBechlem::Vcategory.ivellio_top_categories
      else
        @top_category = MercatorBechlem::Vcategory.where(IDCATEGORY: cat_id).first
        @material_categories = MercatorBechlem::Vcategory.children(category_id)
        @printers = MercatorBechlem::VitemSupply.for_category_id(category_id)
      end

      unless @printers.empty? || cat_id.count("0") > 3
        printer_alternative_numbers = @printers.collect { |printer| "#{printer.ARTNR.gsub("\s", '')}" }.uniq
        @inventories = Inventory.where(alternative_number: printer_alternative_numbers).*.product
      end
    end
  end
end