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

  describe "#create" do 
    it "should return errors" do 
      post "/api/sites"
      parsed_data = JSON.parse( response.body )
      expect(parsed_data).to eq(
        {"message" => "Please type correct data"}
      )
      expect(response).to have_http_status(400)
    end

    it "should return site and success message" do 
      post "/api/sites", :name => "foo"

      expect(response).to have_http_status(200)
      parsed_data = JSON.parse( response.body )
      site = Site.last
      expect(parsed_data).to eq(
        { "site" => JSON.parse(site.to_json) ,
          "message" => "successfully create"} 
      )
      expect(site.name).to eq("foo")
    end
  end

  describe "#edit" do 
    before { @site = Site.create(:name => "test123") }
    it "should error if no any keys" do
      patch "/api/sites/#{@site.id}"
      parsed_data = JSON.parse( response.body )
      expect(parsed_data).to eq(
        {"message" => "Please input the name!"}
      )
      expect(response).to have_http_status(400)
    end

    it "should return site and success message" do 
      patch "/api/sites/#{@site.id}", :name => "I am changing!"
      expect(response).to have_http_status(200)
      parsed_data = JSON.parse( response.body )
      @site.reload
      expect(parsed_data).to eq(
        { "site" => JSON.parse(@site.to_json) ,
          "message" => "successfully edited!"} 
      )
      expect(@site.name).to eq("I am changing!")
    end
  end

  describe "#destroy" do 
    before { @site = Site.create(:name => "test123") }
    it "should return error message" do 
      delete "/api/sites/#{@site.id+1}"
      parsed_data = JSON.parse( response.body)
      expect(parsed_data).to eq(
        {"message" => "please insert right id"}
      )
      expect(response).to have_http_status(400)
    end

    it "should return seccess message" do 
      delete "/api/sites/#{@site.id}"
      parsed_data = JSON.parse( response.body)
      expect(parsed_data).to eq(
        {"message" => "succesfully destroy!"}
      )
    end
  end


end
