namespace :cucumber_test do
  rails_tags = Dir.chdir("vendor/rails") do
    `git tag`.split("\n").reject{|tag| !tag.match(/^v\d+\.\d+\.\d+$/)}[-12..-1] << 'master'
  end

  desc "Test with Rails #{rails_tags.inspect}"
  task :all => rails_tags.map{|tag| "#{tag}:test"}

  rails_tags.each do |tag|
    namespace tag do
      desc "Test with Rails #{tag}"
      task :test => [:banner, :clobber, :checkout, :install, :generate_feature, :generate_scaffold, :migrate] do
        # The features task doesn't exist a priori, so we execute it here.
        sh "rake features"
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
        sh "script/generate cucumber"
      end

      task :generate_feature do
        sh "script/generate feature post title:string body:text published:boolean"
      end

      task :generate_scaffold do
        sh "script/generate rspec_scaffold post title:string body:text published:boolean"
      end

      task :migrate do
        sh "rake db:migrate"
      end
    end
  end
end