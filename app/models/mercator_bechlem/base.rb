module MercatorBechlem
  class Base < ActiveRecord::Base

    establish_connection(:bechlem)
    self.abstract_class = true
    self.connection_config["local_infile"] = true # otherwise imporing from files is prohibitied
    self.connection_config["strict"] = false # otherwise empty nil-values are not allowed in csv.-files

    def self.update_from_download
      tables = ["BRAND", "DESCRIPTOR", "ITEM", "IDENTIFIER", "QUALIFIER", "ITEM2ITEM"]
      tables.each do |table|
        self.connection.execute("TRUNCATE " + table + ";")
        records_array = self.connection.execute(
          "LOAD DATA LOCAL INFILE '" + Access::DESTINATION.to_s + "/" + table +
          ".CSV' REPLACE INTO TABLE " + table + " FIELDS TERMINATED BY ';' LINES TERMINATED BY '\\n';")
      end
    end

    def self.copy_views_to_tables
      self.connection.execute("TRUNCATE item2item_temp;")
      self.connection.execute("TRUNCATE item_printer_temp;")
      self.connection.execute("INSERT IGNORE INTO item_printer_temp SELECT * FROM VITEM_PRINTER;")
      self.connection.execute("INSERT IGNORE INTO item2item_temp SELECT * FROM VITEM2ITEM;")
    end
  end
end