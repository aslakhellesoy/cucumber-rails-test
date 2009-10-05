Rake::Task[:default].prerequisites.clear

desc "Test Cucumber with recent versions of Rails"
task :default => ["cucumber_test:update", "cucumber_test:all"]
