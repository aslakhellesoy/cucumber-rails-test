namespace :cucumber_test do
  rails_tags = ["v2.1.0", "v2.1.1", "v2.1.2", "v2.2.0", "v2.2.1", "v2.2.2", "v2.3.2", "master"]

  desc "Test with Rails #{rails_tags.inspect}"
  task :all => rails_tags.map{|tag| "#{tag}:test"}

  rails_tags.each do |tag|
    namespace tag do
      desc "Test with Rails #{tag}"
      task :test => [:banner, :clobber, :checkout, :install,
                    :generate_feature, :generate_scaffold, :add_sanity_check_for_transactional_fixtures,
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
        sh "script/generate cucumber"
      end

      task :generate_feature do
        sh "script/generate feature post title:string body:text published:boolean"
      end

      task :add_sanity_check_for_transactional_fixtures do
        File.open("features/manage_posts.feature", "a") do |feature|
          feature.puts(<<-END_OF_SCENARIO)

          Scenario: ensure use_transactional_fixtures is working and rolling DB back
            Given I have not created any posts in this scenario
            But the previous scenarios have
            Then there should be 0 posts
          END_OF_SCENARIO
        end

        File.open("features/step_definitions/post_steps.rb", "a") do |definitions|
          definitions.puts(<<-END_OF_DEFINITIONS)
            Given /^I have not created any posts in this scenario$/ do
              # no-op
            end

            Given /^the previous scenarios have$/ do
              # no-op
            end

            Then /^there should be 0 posts$/ do
              Post.count.should == 0
            end
          END_OF_DEFINITIONS
        end

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
