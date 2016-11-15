class PagesController < ApplicationController
	before_action :set_site
	before_action :set_page, :only => [:show, :edit, :update, :destroy]

	def new
		@page = Page.new
	end

	def create
		@page = Page.new(params_permitted)
		if @page.save
			flash[:notice]="新增成功"
			redirect_to site_page_path(@site,@page)
		else
			render :action => :new
		end
	end

	def show

	end

	def edit

	end

	def update
		if @page.update(params_permitted)
			falsh[:notice]= "修改成功"
			redirect_to site_page_path(@site,@page)
		else
			render :action => :edit
		end
	end

	def destroy
		@page.destroy
		flash[:alert]= "刪除成功"
		redirect_to site_path(@site)
	end

	private

	def params_permitted
		params.require(:page).permit(:title, :body, :slug)
	end

	def set_page
		@page = Page.find(params[:id])
	end

	def set_site
		@site = Site.find(params[:site_id])
	end

end
