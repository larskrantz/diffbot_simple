require 'spec_helper'
module DiffbotSimple::V2
	describe CrawlbotApi do
		before(:each) { stubbed_request }
		let(:crawlbot_api) { CrawlbotApi.new token: token, api_client: ApiClient.new }
		let(:response_body) { {body: MultiJson.dump(response) } }
		let(:filtered_response) { response[:jobs].select { |e| e[:type] == "crawl"  } }
		let(:response) { {jobs: [{ type: "crawl", foo: "bar" },{ type: "bulk", should_not: "return" }]} }
		let(:name) { :my_crawl }
		let(:crawl_url) { "#{base_url}/crawl" }
		shared_examples_for "a correct single request" do
			it "should make the stubbed_request" do
				subject
				expect(stubbed_request).to have_been_requested
			end
			it "should return a hashified response" do
				expect(subject).to eql filtered_response.first
			end
		end
		context "when asking for all crawl jobs" do
			let(:subject) { crawlbot_api.all }
			let(:stubbed_request) { stub_request(:get, crawl_url).with(query: {token: token}).to_return(response_body) }
			it "should return the jobs-array" do
				expect(subject).to eql filtered_response
			end
			it "should make the stubbed_request" do
				subject
				expect(stubbed_request).to have_been_requested
			end
		end
		context "when asking for a named crawl job" do
			let(:subject) { crawlbot_api.single name: name }
			let(:stubbed_request) { stub_request(:get, crawl_url).with(query: {token: token, name: name.to_s}).to_return(response_body) }
			it_should_behave_like "a correct single request"
		end
		context "when supplying more arguments to a named crawl job" do
			let(:seeds) { "http://foo.bar,http://bar.foo" }
			let(:notifyEmail) { "noreply@foo.bar" }
			let(:api_url) { "#{base_url}/product" }
			let(:subject) { crawlbot_api.single name: name, seeds: seeds, notifyEmail: notifyEmail, apiUrl: api_url }
			let(:stubbed_request) { stub_request(:get, crawl_url).with(query: {token: token, name: name.to_s, apiUrl: api_url, seeds: seeds, notifyEmail: notifyEmail}).to_return(response_body) }
			it_should_behave_like "a correct single request"
		end
		context "when asking for results for a named crawl job" do
			let(:download_url) { "http://foo.bar" }
			let(:subject) { crawlbot_api.results url: download_url }
			let(:stubbed_request) { stub_request(:get, download_url).to_return([]) }
			it "should make the stubbed_request" do
				subject
				expect(stubbed_request).to have_been_requested
			end
		end
	end
end