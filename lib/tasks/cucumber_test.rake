require 'rbconfig'
RUBY_BINARY   = File.join(Config::CONFIG['bindir'], Config::CONFIG['ruby_install_name'])

namespace :cucumber_test do
  deps = {
    "rails" => ["git://github.com/rails/rails.git", "/vendor/rails"],
    "cucumber" => ["git://github.com/aslakhellesoy/cucumber.git", "/vendor/plugins/cucumber"],
    "cucumber_rails" => ["git://github.com/dbloete/cucumber-rails.git", "/vendor/plugins/cucumber-rails"]
  }

  deps.each_pair do |name, (repo, path)|
    path = RAILS_ROOT + path

    desc "Vendor #{name}"
    task "vendor_#{name}" do
      unless File.exist?(path)
        sh "git clone #{repo} #{path}"
      end
    end

    desc "Update vendored #{name}, vendoring it first if it doesn't exist"
    task "update_#{name}" => "vendor_#{name}" do
      Dir.chdir(path) do
        sh "git checkout master"
        sh "git pull origin master --tags"
      end
    end
  end

  desc "Update vendored versions of rails and cucumber"
  task :update => [:update_rails, :update_cucumber, :update_cucumber_rails]
  
  rails_tags = ["v2.1.0", "v2.1.1", "v2.1.2", "v2.2.0", "v2.2.1", "v2.2.2", "v2.3.2", "v2.3.3", "v2.3.4", "v2.3.5"].reverse

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
        opts = ENV['CUCUMBER_GENERATE_OPTS'] || '--rspec --capybara'
        sh "#{RUBY_BINARY} script/generate cucumber #{opts}"
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
