require 'spec_helper'
module DiffbotSimple::V2
	describe Crawlbot do
		let(:client) { Client.new token: token }
		let(:name) { "crawl_name"}
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
			let(:named_crawl) { stubbed_request; subject.single_crawl name: name, options: {onlyProcessIfNew: 0} }
			let(:stubbed_request) { stub_request(:get, "#{base_url}/crawl").with(query: { name: name, token: token, onlyProcessIfNew: 0 }).to_return(body: '{"jobs":[{"foo":"bar"}]}') }
			it "should make a request to /crawl with the token and name as arguments" do
				named_crawl
				expect(stubbed_request).to have_been_requested
			end
			it "should return an crawl hash" do
				expect(named_crawl).to eql({ foo: 'bar' })
			end
		end
		context "when deleting a named crawl" do
			let(:delete) { stubbed_request; subject.delete name: name }
			let(:stubbed_request) { stub_request(:get, "#{base_url}/crawl").with(query: { name: name, token: token, delete: 1 }).to_return(body: '{"response":"Successfully deleted job." }') }
			it "should make the request to delete it" do
				delete
				expect(stubbed_request).to have_been_requested
			end
			it "should return the faked response" do
				expect(delete).to eql({response: "Successfully deleted job."})
			end
		end
	end
end
