require 'open-uri'
require 'zip'

module MercatorBechlem
  class Access

    attr_accessor(:user, :password, :vendor, :lang, :typ, :base_uri, :full_index_url, :daily_index_url, :open_uri_options)

    USER = CONFIG[:bechlem_user]
    PASSWORD = CONFIG[:bechlem_password]
    URL = "ftp://" + USER + ":" + PASSWORD + "@ww2.kompashop.de/" + CONFIG[:bechlem_filename]
    DESTINATION = Rails.root.join("vendor","bechlem")
    TABLES = ["BRAND", "DESCRIPTOR", "ITEM", "IDENTIFIER", "QUALIFIER", "ITEM2ITEM"]

    # --- Class Methods --- #

    def self.download_index
      io = open( URL, {"Accept-Encoding" => "gzip"})

      Zip::File.open(io) do |zip_file|
        zip_file.each do |f|
          f_path=File.join(DESTINATION, f.name)
          FileUtils.mkdir_p(File.dirname(f_path))
          File.delete(f_path) if File.exist?(f_path)
          zip_file.extract(f, f_path)
        end
      end
      io.close
    end

    def self.delete_first_lines
      TABLES.each do |table|
        filename = DESTINATION.join(table + '.CSV')
        begin
          File.open(filename) do |f|
            f.readline
            File.open(filename.to_s + ".tmp", 'w') do |f2|
              f2 << f.read
            end
          end
          FileUtils.mv(filename.to_s + ".tmp", filename)
        rescue EOFError
          # If the file is empty, no action is needed.
        end
      end
    end
  end
end