namespace :cucumber_test do
  rails_tags = ["v2.1.0", "v2.1.1", "v2.1.2", "v2.2.0", "v2.2.1", "v2.2.2", "v2.3.2", "master"]

  desc "Test with Rails #{rails_tags.inspect}"
  task :all => rails_tags.map{|tag| "#{tag}:test"}

  rails_tags.each do |tag|
    namespace tag do
      desc "Test with Rails #{tag}"
      task :test => [:banner, :clobber, :checkout, :install,
                    :generate_feature, :generate_scaffold,
                    :migrate] do
        # The features task doesn't exist a priori, so we execute it here.
        sh "#{$0} features"
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

      task :install do
        sh "script/generate cucumber #{ENV['CUCUMBER_GENERATE_OPTS']}"
      end

      task :generate_feature do
        sh "script/generate feature post title:string body:text published:boolean"
      end

      task :generate_scaffold do
        sh "script/generate rspec_scaffold post title:string body:text published:boolean"
      end

      task :migrate do
        sh "#{$0} db:migrate"
      end
    end
  end
end
