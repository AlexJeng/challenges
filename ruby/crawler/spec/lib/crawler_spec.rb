require "spec_helper"
require "crawler"

describe Crawler, :vcr => { :cassette_name => "crawler" } do
  subject(:crawler) { Crawler.new }

  it "shows the site map" do
    expect(crawler.site_map["https://gocardless.com/"][:links]).to include(
      "/benefits",
      "/products",
      "/stories",
    )
  end

  context "root url resource" do
    it "includes the assets of the page" do
      expect(crawler.site_map["https://gocardless.com/"][:assets][:images]).to include(
        "/assets/home/home/well-check@2x-1467fb8fffc53db42d1b5b8318027cac.png",
      )

      expect(crawler.site_map["https://gocardless.com/"][:assets][:scripts]).to include(
        "/assets/modernizr-243393d9355546e74748348c65b05265.js",
      )

      expect(crawler.site_map["https://gocardless.com/"][:assets][:styles]).to include(
        "/assets/home/home-manifest-9121c8e3a91191b6f1de85d0854bb4f2.css",
      )
    end
  end

  context "any internal url resource" do
    it "includes the assets of the page" do
      expect(crawler.site_map["https://gocardless.com/stories"][:assets][:images]).to include(
        "/assets/home/footer/footer-logos@2x-8b1137a670f3974ea49c2627be10bf20.png",
      )
    end
  end
end
