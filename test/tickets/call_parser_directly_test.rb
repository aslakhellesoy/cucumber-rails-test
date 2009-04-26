require File.dirname(__FILE__) + '/../test_helper'

class CukeFeatureParser < ActiveSupport::TestCase
  def test_parser
    require 'cucumber'
    Cucumber.load_language('en')
    p = Cucumber::Parser::FeatureParser.new
    f = p.parse_or_fail <<-EOF
Feature: Foo
  Scenario: Bar
    Given Zap
EOF
    sexp = [
      :feature,
      nil,
      "Feature: Foo",
      [:scenario, 2, "Scenario:", "Bar", 
        [:step_invocation, 3, "Given", "Zap"]]]
    assert_equal sexp, f.to_sexp
  end
end