class UniversalAr::InstallGenerator < Rails::Generators::Base #:nodoc:
  include Rails::Generators::Migration
  source_root File.expand_path('../templates', __FILE__)
  require 'rails/generators/migration'

  def self.next_migration_number path
    unless @prev_migration_nr
      @prev_migration_nr = Time.now.utc.strftime("%Y%m%d%H%M%S").to_i
    else
      @prev_migration_nr += 1
    end
    @prev_migration_nr.to_s
  end

  argument :name, type: :string, default: 'universal_ar_migration'
  def generate_files
    migration_template 'universal_ar_migration.rb', "db/migrate/#{name}.rb"
  end

end