module Api
  class SitesController < ::Api::BaseController

    def index
      @sites = Site.all
    end

    def bulk_delete
      params[:ids].each do |id|
        site = Site.find_by_id(id)
        site.destroy
      end

      render :json => {:message => "successfully deleted! "}, :status => 200
    end
  end
end
