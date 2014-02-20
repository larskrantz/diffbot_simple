require 'spec_helper'

module DiffbotSimple::V2
	describe Image do
		let(:client) { Client.new token: token }
		let(:url) { "http://foo.bar" }
		let(:single_response) { { body: {url: url, foo: "bar"}.to_json} }
		let(:image) { client.image }
		shared_examples_for "an image request" do
			it "should make a valid request to the image api" do
				stubbed_request
				subject
				expect(stubbed_request).to have_been_requested
			end
			it "should return the response body as an symbolized hash" do
				stubbed_request
				expect(subject).to eql JSON.parse(single_response[:body], symbolize_names: true)
			end
		end
		context "when asking for an image with no options" do
			let(:subject) { image.single_image url: url}
			let(:stubbed_request) { stub_request(:get, "#{base_url}/image").with(query: {token: token, url: url}).to_return(single_response) }
			it_should_behave_like "an image request"
		end
		context "when asking for an image with image options" do
			let(:fields) {"a,b,c"}
			let(:callback) { "my_callback" }
			let(:timeout) { 4200 }
			let(:subject) { image.single_image url: url, timeout: timeout, callback: callback, fields: fields }
			let(:stubbed_request) { stub_request(:get, "#{base_url}/image").with(query: {token: token, url: url, timeout: timeout, callback: callback, fields: fields}).to_return(single_response) }
			it_should_behave_like "an image request"
		end
	end
end