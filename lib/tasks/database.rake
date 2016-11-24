db_namespace = namespace :db do
  namespace :test do
    desc 'Prepares the test database and then runs seeds against it'
    task :bootstrap => ["db:test:prepare"] do
      Rails.env = 'test'
      Rake::Task['db:seed'].invoke
    end
  end
end
