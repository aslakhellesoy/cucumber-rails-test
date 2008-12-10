namespace :cucumber_test do
  desc 'Install Cucumber'
  task :install do
    sh "script/generate cucumber"
  end
  
  desc 'Generate a feature'
  task :generate_feature do
    sh "script/generate feature post title:string body:text published:boolean"
  end

  desc 'Generate scaffolding'
  task :generate_scaffold do
    sh "script/generate rspec_scaffold post title:string body:text published:boolean"
  end
  
  desc 'Clobber all generated artefacts'
  task :clobber do
    sh "git checkout ."
    sh "git clean -d -f"
  end
end