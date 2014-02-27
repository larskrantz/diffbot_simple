require 'spec_helper'
module DiffbotSimple::V2
	describe BulkFactory do
		before(:each) { stubbed_request }
		let(:bulk_factory) { BulkFactory.new token: token, api_client: ApiClient.new }
		let(:response_body) { {body: MultiJson.dump(response) } }
		let(:response) { {jobs: [{ foo: "bar" }]} }
		let(:name) { :my_bulk_job }
		shared_examples_for "a correct request" do
			it "should make the stubbed_request" do
				subject
				expect(stubbed_request).to have_been_requested
			end
		end
		context "when asking for all bulks" do
			let(:subject) { bulk_factory.all }
			let(:stubbed_request) { stub_request(:get, "#{base_url}/bulk").with(query: {token: token}).to_return(response_body) }
			it "should return the jobs-array" do
				expect(subject.map { |e| e.parameters  }).to eql response[:jobs]
			end
		end
		context "when asking for a named bulk" do
			let(:subject) { bulk_factory.single name: name }
			let(:stubbed_request) { stub_request(:get, "#{base_url}/bulk").with(query: {token: token, name: name.to_s}).to_return(response_body) }
			it_should_behave_like "a correct request"
		end
	end
end