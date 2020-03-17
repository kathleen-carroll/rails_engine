require 'csv'

# desc "Import customers from csv file"

task :load_seed => [:import_customers]

# namespace :import_seeds do
  task :import_customers => [ :environment] do
    puts 'Importing Customers CSV data'

    file = "db/data/customers.csv"

    ActiveRecord::Base.connection.execute("TRUNCATE TABLE CUSTOMERS RESTART IDENTITY;")

    CSV.foreach(file, :headers => true) do |row|
      # require "pry"; binding.pry
      # ActiveRecord::Base.connection.execute("ALTER SEQUENCE customers_id_seq RESTART WITH 1;")
      ActiveRecord::Base.connection.execute("ALTER SEQUENCE customers_id_seq RESTART;")
      Customer.create(row.to_hash)
        # id: row["id"],
        # first_name: row[1],
        # last_name: row["last_name"
    end
  end

  # task :import_invoice_items => [ :environment] do
  #   puts 'Importing Invoice Items CSV data'
  #
  #   file = "db/data/invoice_items.csv"
  #
  #   CSV.foreach(file, :headers => true) do |row|
  #     require "pry"; binding.pry
  #     Customer.create(
  #       id: row["id"],
  #       first_name: row[1],
  #       last_name: row["last_name"]
  #     )
  #
  #     #   name: row[1],
  #     #   :league => row[2],
  #     #   :some_other_data => row[4]
  #     # }
  #   end
  # end

# end
