class FailingController < ApplicationController
  def index
    raise 'FAIL'
  end
end