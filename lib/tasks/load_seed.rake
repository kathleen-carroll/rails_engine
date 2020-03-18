require 'csv'

task :load_seed => [:reset, :import_customers, :import_merchants, :import_invoices, :import_items, :import_invoice_items, :import_transactions]

  task :reset => [ :environment] do
    puts 'Reset all primary keys'

    ActiveRecord::Base.connection.execute("TRUNCATE TABLE CUSTOMERS, INVOICES, ITEMS, MERCHANTS, INVOICE_ITEMS, TRANSACTIONS RESTART IDENTITY;")
  end

  task :import_customers => [ :environment] do
    puts 'Importing Customers CSV data'

    file = "db/data/customers.csv"

    CSV.foreach(file, :headers => true) do |row|
      ActiveRecord::Base.connection.execute("ALTER SEQUENCE customers_id_seq RESTART;")
      Customer.create(row.to_hash)
    end
  end

  task :import_merchants => [ :environment] do
    puts 'Importing Merchants CSV data'

    file = "db/data/merchants.csv"

    CSV.foreach(file, :headers => true) do |row|
      ActiveRecord::Base.connection.execute("ALTER SEQUENCE merchants_id_seq RESTART;")
      Merchant.create(row.to_hash)
    end
  end

  task :import_invoices => [ :environment] do
    puts 'Importing Invoices CSV data'
    file = "db/data/invoices.csv"

    CSV.foreach(file, :headers => true) do |row|
      ActiveRecord::Base.connection.execute("ALTER SEQUENCE invoices_id_seq RESTART;")

      Invoice.create(row.to_hash)
    end
  end

  task :import_items => [ :environment] do
    puts 'Importing Items CSV data'

    file = "db/data/items.csv"

    CSV.foreach(file, :headers => true) do |row|
      ActiveRecord::Base.connection.execute("ALTER SEQUENCE items_id_seq RESTART;")
      item_hash = row.to_hash
      item_hash["unit_price"] = item_hash["unit_price"].to_f/100

      Item.create(item_hash)
    end
  end

  task :import_invoice_items => [ :environment] do
    puts 'Importing Invoice Items CSV data'

    file = "db/data/invoice_items.csv"

    CSV.foreach(file, :headers => true) do |row|
      ActiveRecord::Base.connection.execute("ALTER SEQUENCE invoice_items_id_seq RESTART;")

      invoice_item_hash = row.to_hash
      invoice_item_hash["unit_price"] = invoice_item_hash["unit_price"].to_f/100
      InvoiceItem.create(invoice_item_hash)
    end
  end

  task :import_transactions => [ :environment] do
    puts 'Importing Transactions CSV data'

    file = "db/data/transactions.csv"

    CSV.foreach(file, :headers => true) do |row|
      ActiveRecord::Base.connection.execute("ALTER SEQUENCE transactions_id_seq RESTART;")
      Transaction.create(row.to_hash)
    end
  end
