require 'rails_helper'

RSpec.describe Api::SitesController, type: :request do
  describe "#index" do
    before { FactoryGirl.create(:site) }

    subject do
      get "/api/sites.json"
      JSON.parse(response.body)
    end

    it { expect(subject["sites"].size).to be > 0 }

    it "http status" do
      subject
      expect(response.status).to eq(200)
    end
  end

  describe "#bulk_delete" do
    before do 
      FactoryGirl.create(:site)
      FactoryGirl.create(:site)
      FactoryGirl.create(:site)
    end

    it "should delete all datas" do
      
      expect(Site.all.size).to be(3)
      delete_list = Site.all.map{|v| v.id }
      post "/api/sites/bulk_delete", :ids => delete_list
      expect(Site.all.size).to be(0)
    end

  end
end
