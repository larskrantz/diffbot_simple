require 'spec_helper'

module DiffbotSimple::V2
	describe Crawlbot do
		let(:base_url) {"http://api.diffbot.com/v2"}
		let(:token) { "TestToken" }
		let(:client) { Client.new token: token }
		let(:subject) { client.crawlbot }
		context "when retreiving all crawls" do
			let(:all) { subject.all_crawls }
			let(:request) { stub_request(:get, "#{base_url}/crawl?token=#{token}") }
			it "should make an request to /crawl with the token as argument" do
				crawls = all
				expect(request).to have_been_requested
			end
		end
	end
end