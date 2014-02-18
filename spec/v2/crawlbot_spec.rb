require 'spec_helper'
module DiffbotSimple::V2
	describe Crawlbot do
		let(:client) { Client.new token: token }
		let(:subject) { client.crawlbot }
		context "when retreiving all crawls" do
			let(:all) { stubbed_request;subject.all; }
			let(:stubbed_request) { stub_request(:get, "#{base_url}/crawl").with(query: {token: token}).to_return( body: '{"jobs":[{"foo":"bar"}]}', status: 200) }
			it "should make a request to /crawl with the token as argument" do
				all
				expect(stubbed_request).to have_been_requested
			end
			it "should return an crawl array " do
				expect(all).to eql([{ foo: 'bar' }])
			end
		end
		context "when asking for a named crawl" do
			let(:name) { "crawl_name"}
			let(:named_crawl) { stubbed_request; subject.single_crawl name: name }
			let(:stubbed_request) { stub_request(:get, "#{base_url}/crawl").with(query: { name: name, token: token }).to_return(body: '{"jobs":[{"foo":"bar"}]}') }
			it "should make a request to /crawl with the token and name as arguments" do
				named_crawl
				expect(stubbed_request).to have_been_requested
			end
			it "should return an crawl hash" do
				expect(named_crawl).to eql({ foo: 'bar' })
			end
		end
	end
end
