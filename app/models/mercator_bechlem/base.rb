module MercatorBechlem
  class Base < ActiveRecord::Base

    establish_connection(:bechlem)
    self.abstract_class = true

    def self.update_from_download
      tables = ["BRAND", "DESCRIPTOR", "ITEM", "IDENTIFIER", "QUALIFIER", "ITEM2ITEM"]
      tables.each do |table|
        self.connection_config["local_infile"] = true
        self.connection_config["strict"] = false
        records_array = self.connection.execute(
          "LOAD DATA LOCAL INFILE '" + Access::DESTINATION.to_s + "/" + table +
          ".CSV' REPLACE INTO TABLE " + table + " FIELDS TERMINATED BY ';' LINES TERMINATED BY '\\n';")
      end
    end

    def self.copy_views_to_tables
      self.connection_config["local_infile"] = true
      self.connection_config["strict"] = false
      self.connection.execute("TRUNCATE item2item_temp;")
      self.connection.execute("TRUNCATE item_printer_temp;")
      self.connection.execute("INSERT IGNORE INTO item_printer_temp SELECT * FROM VITEM_PRINTER;")
      self.connection.execute("INSERT IGNORE INTO item2item_temp SELECT * FROM VITEM2ITEM;")
    end
  end
end