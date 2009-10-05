Rake::Task[:default].prerequisites.clear
task :default => ["cucumber_test:pull", "cucumber_test:all"]
