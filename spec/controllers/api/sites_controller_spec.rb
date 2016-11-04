require 'rails_helper'

RSpec.describe Api::SitesController, type: :request do

  describe "#index" do
    before { FactoryGirl.create(:site) }
 
    subject do
      get "/api/sites.json", {},  'HTTP_ACCEPT_LANGUAGE' => 'zh-TW' 
      JSON.parse(response.body)
    end

    it { expect(subject["sites"].size).to be > 0 }

    it "http status" do
      subject
      expect(response.status).to eq(200)
    end
  end

  describe "#create" do 
    it "should return errors" do 
      post "/api/sites", {},  'HTTP_ACCEPT_LANGUAGE' => 'zh-TW'
      parsed_data = JSON.parse( response.body )
      expect(parsed_data).to eq(
        {"message" => I18n.t("create.failure")}
      )
      expect(response).to have_http_status(400)
    end

    it "should return site and success message" do 
      post "/api/sites", {:name => "foo"}, {'HTTP_ACCEPT_LANGUAGE' => 'zh-TW'}

      expect(response).to have_http_status(200)
      parsed_data = JSON.parse( response.body )
      site = Site.last
      expect(parsed_data).to eq(
        { "site" => JSON.parse(site.to_json) ,
          "message" => I18n.t("create.success")} 
      )
      expect(site.name).to eq("foo")
    end
  end

  describe "#edit" do 
    before { @site = Site.create(:name => "test123") }
    it "should error if no any keys" do
      patch "/api/sites/#{@site.id}", {},  'HTTP_ACCEPT_LANGUAGE' => 'zh-TW'
      parsed_data = JSON.parse( response.body )
      expect(parsed_data).to eq(
        {"message" => I18n.t("edit.failure")}
      )
      expect(response).to have_http_status(400)
    end

    it "should return site and success message" do 
      patch "/api/sites/#{@site.id}", {:name => "I am changing!"} , {'HTTP_ACCEPT_LANGUAGE' => 'zh-TW'}
      expect(response).to have_http_status(200)
      parsed_data = JSON.parse( response.body )
      @site.reload
      expect(parsed_data).to eq(
        { "site" => JSON.parse(@site.to_json) ,
          "message" => I18n.t("edit.success")} 
      )
      expect(@site.name).to eq("I am changing!")
    end
  end

  describe "#destroy" do 
    before { @site = Site.create(:name => "test123") }
    it "should return error message" do 
      delete "/api/sites/#{@site.id+1}", {},  'HTTP_ACCEPT_LANGUAGE' => 'zh-TW'
      parsed_data = JSON.parse( response.body)
      expect(parsed_data).to eq(
        {"message" => I18n.t("destroy.failure")}
      )
      expect(response).to have_http_status(400)
    end

    it "should return seccess message" do 
      delete "/api/sites/#{@site.id}", {},  'HTTP_ACCEPT_LANGUAGE' => 'zh-TW'
      parsed_data = JSON.parse( response.body)
      expect(parsed_data).to eq(
        {"message" => I18n.t("destroy.success")}
      )
    end
  end


end
