namespace :bechlem do
  # starten als: 'bundle exec rake bechlem:import'
  # in Produktivumgebungen: 'bundle exec rake bechlem:import RAILS_ENV=production'
  desc 'Import crosselling data from Bechlem'
  task :import => :environment do

    ::JobLogger.info("=" * 50)
    ::JobLogger.info("Started Job: bechlem:import")
    MercatorBechlem::Access.download_index
    ::JobLogger.info("Bechlem Index downloaded (1/4) ...")
    MercatorBechlem::Access.delete_first_lines
    ::JobLogger.info("... first lines deleted (2/4) ...")
    MercatorBechlem::Base.update_from_download
    ::JobLogger.info("... tables imported (3/4) ...")
    MercatorBechlem::Base.copy_views_to_tables
    ::JobLogger.info("... views copied to tables (4/4)")
    ::JobLogger.info("Finished Job: bechlem:import")
    ::JobLogger.info("=" * 50)
  end
end