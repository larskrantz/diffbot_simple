require 'spec_helper'

module DiffbotSimple::V2
	describe Analyze do
		let(:client) { Client.new token: token }
		let(:url) { "http://foo.bar" }
		let(:single_response) { { body: {url: url, foo: "bar"}.to_json} }
		let(:analyze) { client.analyze }
		let(:api_url) { "#{base_url}/analyze" }
		shared_examples_for "an analyze request" do
			before(:each) { stubbed_request }
			it "should make a valid request to the analyze api" do
				subject
				expect(stubbed_request).to have_been_requested
			end
			it "should return the response body as an symbolized hash" do
				expect(subject).to eql JSON.parse(single_response[:body], symbolize_names: true)
			end
			it "should respond and return the apis url in to_crawl_api_url" do
				expect(analyze.to_crawl_api_url).to eql "#{api_url}?mode=auto"
			end
		end
		context "when asking for an analyze with no options" do
			let(:subject) { analyze.single_analysis url: url}
			let(:stubbed_request) { stub_request(:get, api_url).with(query: {token: token, url: url}).to_return(single_response) }
			it_should_behave_like "an analyze request"
		end
		context "when asking for an analyze with analyze options" do
			let(:fields) {"a,b,c"}
			let(:mode) { "article" }
			let(:stats) { true }
			let(:subject) { analyze.single_analyze url: url, stats: stats, mode: mode, fields: fields }
			let(:stubbed_request) { stub_request(:get, api_url).with(query: {token: token, url: url, stats: stats.to_s, mode: mode, fields: fields}).to_return(single_response) }
			it_should_behave_like "an analyze request"
		end
	end
end