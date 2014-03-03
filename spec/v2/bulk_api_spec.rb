require 'spec_helper'
module DiffbotSimple::V2
	describe BulkApi do
		before(:each) { stubbed_request }
		let(:bulk_api) { BulkApi.new token: token, api_client: ApiClient.new }
		let(:response_body) { {body: MultiJson.dump(response) } }
		let(:response) { {jobs: [{ foo: "bar" }]} }
		let(:name) { :my_bulk_job }
		let(:bulk_url) { "#{base_url}/bulk" }
		shared_examples_for "a correct single request" do
			it "should make the stubbed_request" do
				subject
				expect(stubbed_request).to have_been_requested
			end
			it "should return a hashified response" do
				expect(subject).to eql response[:jobs].first
			end
		end
		context "when asking for all bulk jobs" do
			let(:subject) { bulk_api.all }
			let(:stubbed_request) { stub_request(:get, bulk_url).with(query: {token: token}).to_return(response_body) }
			it "should return the jobs-array" do
				expect(subject).to eql response[:jobs]
			end
			it "should make the stubbed_request" do
				subject
				expect(stubbed_request).to have_been_requested
			end
		end
		context "when asking for a named bulk job" do
			let(:subject) { bulk_api.single name: name }
			let(:stubbed_request) { stub_request(:get, bulk_url).with(query: {token: token, name: name.to_s}).to_return(response_body) }
			it_should_behave_like "a correct single request"
		end
		context "when supplying more arguments to a named bulk job" do
			let(:urls) { "http://foo.bar,http://bar.foo" }
			let(:notifyEmail) { "noreply@foo.bar" }
			let(:api_url) { "#{base_url}/product" }
			let(:subject) { bulk_api.single name: name, urls: urls, notifyEmail: notifyEmail, apiUrl: api_url }
			let(:stubbed_request) { stub_request(:get, bulk_url).with(query: {token: token, name: name.to_s, apiUrl: api_url, urls: urls, notifyEmail: notifyEmail}).to_return(response_body) }
			it_should_behave_like "a correct single request"
		end

	end
end