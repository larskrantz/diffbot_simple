
require 'spec_helper'

module DiffbotSimple::V2
	describe Custom do
		let(:client) { Client.new token: token }
		let(:url) { "http://foo.bar" }
		let(:single_response) { { body: {url: url, foo: "bar"}.to_json} }
		let(:custom_name) { "foobar" }
		let(:custom) { client.custom name: custom_name }
		shared_examples_for "a custom request" do
			it "should make a valid request to the custom api" do
				stubbed_request
				subject
				expect(stubbed_request).to have_been_requested
			end
			it "should return the response body as an symbolized hash" do
				stubbed_request
				expect(subject).to eql JSON.parse(single_response[:body], symbolize_names: true)
			end
		end
		context "when asking for a custom api with no options" do
			let(:subject) { custom.single_custom url: url }
			let(:stubbed_request) { stub_request(:get, "#{base_url}/api/#{CGI::escape(custom_name)}").with(query: {token: token, url: url }).to_return(single_response) }
			it_should_behave_like "a custom request"
		end
		context "when asking for a custom api with custom options" do
			let(:subject) { custom.single_custom url: url, timeout: 12000, callback: "my_callback" }
			let(:stubbed_request) { stub_request(:get, "#{base_url}/api/#{CGI::escape(custom_name)}").with(query: {token: token, url: url, timeout: 12000, callback: "my_callback" }).to_return(single_response) }
			it_should_behave_like "a custom request"
		end
	end
end