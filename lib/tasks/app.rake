task :update_datapa => ["company:retrieve_latest", "sector:retrieve_latest", "sector:populate_by_sector"]