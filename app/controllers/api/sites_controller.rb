module Api
  class SitesController < ::Api::BaseController

    def index
      @sites = Site.all
    end


    def create
    	@site= Site.new(:name => params[:name], :host => params[:host], :subdomain => params[:subdomain], :data => params[:data])
    	if @site.save
    		render :json => { :site => JSON.parse(@site.to_json), :message => I18n.t("create.success")}, :status => 200
    	else
    		render :json => {:message => I18n.t("create.failure")}, :status => 400
    	end
    end

    def update
    	@site = Site.find(params[:id])
    	if @site.update(:name => params[:name], :host => params[:host], :subdomain => params[:subdomain], :data => params[:data])
				render :json => {:site => JSON.parse(@site.to_json) ,:message => I18n.t("edit.success")}, :status => 200
			else
				render :json => { :message => I18n.t("edit.failure") }, :status => 400
			end
		end

		def destroy
			@site = Site.find_by_id(params[:id])
			if @site
				@site.destroy
				render :json => { :message => I18n.t("destroy.success")}
			else
				render :json => { :message => I18n.t("destroy.failure")}, :status => 400
			end
		end
  end
end
