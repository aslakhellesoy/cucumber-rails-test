require 'rbconfig'
RUBY_BINARY   = File.join(Config::CONFIG['bindir'], Config::CONFIG['ruby_install_name'])
VENDOR_RAILS = RAILS_ROOT + "/vendor/rails"
VENDOR_CUCUMBER = RAILS_ROOT + "/vendor/plugins/cucumber"

namespace :cucumber_test do
  task :clone_rails do
    unless File.exist?(VENDOR_RAILS)
      puts "Vendoring Rails..."
      sh "git clone git://github.com/rails/rails.git #{VENDOR_RAILS}"
    end
  end

  task :clone_cucumber do
    unless File.exist?(VENDOR_CUCUMBER)
      puts "Vendoring Cucumber..."
      sh "git clone git://github.com/aslakhellesoy/cucumber.git #{VENDOR_CUCUMBER}"
    end
  end

  task :pull_rails => :clone_rails do
    puts "Updating vendored rails..."
    Dir.chdir(VENDOR_RAILS) do
      sh "git pull origin master"
    end
  end

  task :pull_cucumber => :clone_cucumber do
    puts "Updating vendored cucumber..."
    Dir.chdir(VENDOR_CUCUMBER) do
      sh "git pull origin master"
    end
  end

  task :pull => [:pull_rails, :pull_cucumber]

  rails_tags = ["v2.1.0", "v2.1.1", "v2.1.2", "v2.2.0", "v2.2.1", "v2.2.2", "v2.3.2", "v2.3.3"]

  desc "Test with Rails #{rails_tags.inspect}"
  task :all => rails_tags.map{|tag| "#{tag}:test"}

  rails_tags.each do |tag|
    namespace tag do
      desc "Test with Rails #{tag}"
      task :test => [
        :banner, 
        :clobber, 
        :checkout,
        :database_yml, 
        :install,
        :generate_feature,
        :generate_scaffold,
        :migrate
      ] do
        # The cucumber task doesn't exist a priori, so we execute it here.
        sh "#{$0} cucumber:all"
      end

      task :banner do
        puts "========================================"
        puts "============= Rails #{tag} ============="
        puts "========================================"
      end

      task :clobber do
        sh "git checkout ."
        sh "git clean -d -f"
      end

      task :checkout do
        Dir.chdir("vendor/rails") do
          system "git checkout #{tag}"
        end
      end

      task :database_yml do
        if defined?(JRUBY_VERSION)
          cp 'config/database_jdbcmysql.yml', 'config/database.yml'
          %w{development test}.each do |db|
            sh "mysqladmin -u root -f drop cucumber_#{db}" rescue nil
            sh "mysqladmin -u root create cucumber_#{db}"
          end
        else
          cp 'config/database_sqlite3.yml', 'config/database.yml'
        end
      end

      task :install do
        sh "#{RUBY_BINARY} script/generate cucumber #{ENV['CUCUMBER_GENERATE_OPTS']}"
      end

      task :generate_feature do
        sh "#{RUBY_BINARY} script/generate feature post title:string body:text published:boolean"
      end

      task :generate_scaffold do
        sh "#{RUBY_BINARY} script/generate rspec_scaffold post title:string body:text published:boolean"
      end

      task :migrate do
        sh "#{$0} db:migrate"
      end
    end
  end
end
