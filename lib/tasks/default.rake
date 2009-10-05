Rake::Task[:default].prerequisites.clear

desc "Test Cucumber with recent versions of Rails"
task :default => ["cucumber_test:update", "cucumber_test:all"] do
  Dir.chdir(RAILS_ROOT + "/vendor/rails") do
    puts "Putting vendored Rails into a usable state for next run"
    sh "git checkout v2.2.2" 
  end
end
