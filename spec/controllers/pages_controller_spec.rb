require 'rails_helper'

RSpec.describe PagesController, type: :request do
	let(:site) { FactoryGirl.create :site }
	byebug

	describe "POST site/pages" do 
		let(:params) { { title: "test"} } 
		byebug
		let(:headers) { { "HTTP_REFERER" => "/sites//pages" } }
			
	end



end
