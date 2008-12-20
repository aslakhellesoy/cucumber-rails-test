namespace :cucumber_test do
  desc 'Clobber all generated artefacts'
  task :clobber do
    sh "git checkout ."
    sh "git clean -d -f"
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
  
  rails_tags = Dir.chdir("vendor/rails") do
    `git tag`.split("\n")[-5..-1] << 'master'
  end
  
  rails_tags.each do |tag|
    task :checkout do
      system "git checkout #{tag}"
    end
    
    desc "Test with Rails #{tag}"
    task tag.to_sym => [:clobber, :checkout, :install, :generate_feature, :generate_scaffold, 'db:migrate'] do
      # The features task doesn't exist a priori, so we execute it here.
      sh "rake features"
    end
  end
end