require 'spec_helper'

module DiffbotSimple::V2
	describe Product do
		let(:client) { Client.new token: token }
		let(:url) { "http://foo.bar" }
		let(:single_response) { { body: {url: url, foo: "bar"}.to_json} }
		let(:product) { client.product }
		let(:api_url) { "#{base_url}/product" }
		shared_examples_for "a product request" do
			before(:each) { stubbed_request }
			it "should make a valid request to the product api" do
				subject
				expect(stubbed_request).to have_been_requested
			end
			it "should return the response body as an symbolized hash" do
				expect(subject).to eql JSON.parse(single_response[:body], symbolize_names: true)
			end
			it "should respond and return the apis url in to_api_url" do
				expect(product.to_api_url).to eql api_url
			end
		end
		context "when asking for a product with no options" do
			let(:subject) { product.request url: url}
			let(:stubbed_request) { stub_request(:get, api_url).with(query: {token: token, url: url}).to_return(single_response) }
			it_should_behave_like "a product request"
		end
		context "when asking for a product with product options" do
			let(:fields) {"a,b,c"}
			let(:callback) { "my_callback" }
			let(:timeout) { 4200 }
			let(:subject) { product.request url: url, timeout: timeout, callback: callback, fields: fields }
			let(:stubbed_request) { stub_request(:get, api_url).with(query: {token: token, url: url, timeout: timeout, callback: callback, fields: fields}).to_return(single_response) }
			it_should_behave_like "a product request"
		end
	end
end