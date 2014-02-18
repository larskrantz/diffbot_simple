require 'spec_helper'
module DiffbotSimple::V2
	describe Crawlbot do
		let(:client) { Client.new token: token }
		let(:subject) { client.crawlbot }
		context "when retreiving all crawls" do
			let(:all) { stubbed_request;subject.all; }
			let(:stubbed_request) { stub_request(:get, "#{base_url}/crawl?token=#{token}").to_return( body: '{"jobs":[{"foo":"bar"}]}', status: 200) }
			it "should make an request to /crawl with the token as argument" do
				all
				expect(stubbed_request).to have_been_requested
			end
			it "should return a symbolize hash" do
				expect(all).to eql({jobs: [{ foo: 'bar' }]})
			end
		end
	end
end