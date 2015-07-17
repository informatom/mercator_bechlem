class ConsumablesController < ApplicationController

  hobo_controller

  def products
    @printer = params[:id]
    @printer ||= try_to{ MercatorBechlem::VitemPrinter.where(brand: "HP", DESCRIPTION: params[:printer]).first.IDITEM }

    if @printer
      icecat_products = MercatorBechlem::Vitem2item.where(IDITEM: @printer )
      @printer_description = MercatorBechlem::VitemPrinter.find_by(IDITEM: @printer).DESCRIPTION
      alternative_numbers = icecat_products.collect { |product| "#{product.ARTNR.gsub("\s", '')}" }.uniq
                                                              # gsub removes whitespace characters, compact removes nil elements
      @products = Inventory.where(alternative_number: alternative_numbers).*.product.uniq
      @active_products = @products.find_all{|product| product.state == "active" }
      @printerseries = MercatorBechlem::VitemPrinter.find_by(IDITEM: @printer).PRINTERSERIES
    end
  end


  def printers
    @printerserie = params[:id]

    @printer_series = MercatorBechlem::VitemPrinter.where(brand: "HP")
                                                   .where.not(printerseries: nil)
                                                   .order(PRINTERSERIES: :asc)
    @printer_series_names = @printer_series.*.PRINTERSERIES.uniq

    if @printerserie == "All"
      @printer_names = MercatorBechlem::VitemPrinter.where(brand: "HP")
                                                    .order(DESCRIPTION: :asc).*
                                                    .DESCRIPTION
                                                    .uniq
    else
      @printer_names = MercatorBechlem::VitemPrinter.where(brand: "HP", printerseries: @printerserie)
                                                    .order(DESCRIPTION: :asc).*
                                                    .DESCRIPTION
                                                    .uniq
      @printers = MercatorBechlem::VitemPrinter.where(brand: "HP", printerseries: @printerserie)
                                               .select("CATEGORY, BRAND, DESCRIPTION, IDITEM")
                                               .order(DESCRIPTION: :asc)
    end
  end


  def category
    category_id = (params[:id] == "All") ? "145200000" : params[:id]
    @category = MercatorBechlem::Vcategory.where(IDCATEGORY: category_id).first
    @ancestors = try_to { @category.ancestors }
    @children = @category ? @category.children : MercatorBechlem::Vcategory.top_categories

    @printers = MercatorBechlem::VitemSupply.for_category_id(params[:id])

    if @printers && @category && @category.parent
      printer_alternative_numbers = @printers.collect { |printer| "#{printer.ARTNR.gsub("\s", '')}" }
                                             .uniq
      @products = Inventory.where(alternative_number: printer_alternative_numbers).*
                           .product
                           .uniq
      @active_products = @products.find_all{|product| product.state == "active" }
    end
  end
end
