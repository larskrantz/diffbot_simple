
require 'spec_helper'
module DiffbotSimple::V2
	describe Bulk do
		let(:client) { Client.new token: token }
		let(:bulk_name) { :my_bulk }
		let(:bulk) { client.bulk name: bulk_name }
		let(:all) { client.bulk }
		context "when retreiving all bulks" do
			before(:each) { stubbed_request }
			let(:response_body) { {body: MultiJson.dump(response) } }
			let(:response) { {jobs: [{ foo: "bar" }]} }
			let(:stubbed_request) { stub_request(:get, "#{base_url}/bulk").with(query: {token: token}).to_return(response_body) }
			it "should make a request to /bulk with token as the argument" do
				all
				expect(stubbed_request).to have_been_requested
			end
			it "should return the jobs-array" do
				expect(all.map { |e| e.parameters  }).to eql response[:jobs]
			end
		end
	end
end