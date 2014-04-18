require 'open-uri'
require 'zip/zip'

module MercatorBechlem
  class Access

    attr_accessor(:user, :password, :vendor, :lang, :typ, :base_uri, :full_index_url, :daily_index_url, :open_uri_options)

    USER = "MB_Daten_Ivellio-Vellin"
    PASSWORD = "247r9fhs47hefe4"
    URL = "ftp://" + USER + ":" + PASSWORD + "@ww2.kompashop.de/Ivellio_Vellin.zip"
    DESTINATION = Rails.root.join("vendor","bechlem")
    TABLES = ["BRAND", "DESCRIPTOR", "ITEM", "IDENTIFIER", "QUALIFIER", "ITEM2ITEM"]

    # --- Class Methods --- #

    def self.download_index

      io = open( URL, {"Accept-Encoding" => "gzip"})
      Zip::ZipFile.open(io) do |zip_file|
        zip_file.each do |f|
          f_path=File.join(DESTINATION, f.name)
          FileUtils.mkdir_p(File.dirname(f_path))
          zip_file.extract(f, f_path) unless File.exist?(f_path)
        end
      end
      io.close
    end

    def self.delete_first_lines
      TABLES.each do |table|
        filename = DESTINATION.join(table + '.CSV')
        File.open(filename) do |f|
          f.readline
          File.open(filename.to_s + ".tmp", 'w') do |f2|
            f2 << f.read
          end
        end
        FileUtils.mv(filename.to_s + ".tmp", filename)
      end
    end

  end
end