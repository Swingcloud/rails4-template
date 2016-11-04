module Api
  class BaseController < ApplicationController
  	skip_before_action :verify_authenticity_token
    def index
      @message = "api root"
    end
  end
end
