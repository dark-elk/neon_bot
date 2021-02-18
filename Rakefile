# frozen_string_literal: true

ENV['PROJECT_APPS'] = 'rake'
require_relative 'config/enviroment'
require 'rom-sql'
require 'rom/sql/rake_task'

namespace :db do
  task :setup do
    Container.start(:db)

    ROM::SQL::RakeSupport.env = ROM.container(Container['db.config']) do |config|
      config.gateways[:default].use_logger(Container[:logger])
    end
  end

  desc 'Rolls the schema back to the previous version'
  task rollback: :'db:setup' do
    db = ROM::SQL::RakeSupport.env.gateways[:default].connection
    migrations = db[:schema_migrations].order(Sequel.desc(:filename)).select(:filename).limit(2).all
                                       .map { |sm| sm[:filename][/\d+/].to_i }
    next if migrations.empty?

    target = migrations.count == 1 ? 0 : migrations.last

    ROM::SQL::RakeSupport.run_migrations(target: target)
    puts "<= db:rollback executed for version #{migrations.first}"
  end

  desc 'Perform db:rollback and db:migrate'
  task redo: :'db:setup' do
    Rake::Task['db:rollback'].execute
    Rake::Task['db:migrate'].execute
  end

  namespace :migrate do
    desc 'Display status of migrations'
    task status: :'db:setup' do
      db = ROM::SQL::RakeSupport.env.gateways[:default].connection
      versions_executed = db[:schema_migrations].order(Sequel.asc(:filename)).select(:filename).all
                                                .map { |sm| sm[:filename][/^\d+/].to_i }
      migration_files = Dir["#{Container.root}/db/migrate/*.rb"]
      versions_in_files = migration_files.map { |fn| fn[/\d+/].to_i }.sort.reverse!
      migration_files_base_names = migration_files.map { |fn| File.basename(fn) }

      no_file = '********** NO FILE **********'
      up = '  up    '
      down = ' down   '

      versions = versions_executed | versions_in_files
      versions.each do |version|
        status = versions_executed.include?(version) ? up : down
        file_name = migration_files_base_names.find { |fn| fn.start_with?(version.to_s) } || no_file

        puts "#{status} #{version} #{file_name}"
      end
    end
  end
end
