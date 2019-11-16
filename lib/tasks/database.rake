namespace :database do
    desc "Correction of sequences id"
    task seq_reset: :environment do
      ActiveRecord::Base.connection.tables.each do |t|
        ActiveRecord::Base.connection.reset_pk_sequence!(t)
      end
    end
  end
  