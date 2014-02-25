require 'spec_helper'
module DiffbotSimple::V2
	describe Crawlbot do
		let(:client) { Client.new token: token }
		let(:custom) { client.custom name: "my_custom_api" }
		let(:single_crawl_response_body) {{body: '{"jobs":[{"foo":"bar"}]}'}}
		let(:name) { "crawl_name"}
		let(:subject) { client.crawlbot }
		context "when retreiving all crawls" do
			let(:all) { stubbed_request;subject.all; }
			let(:stubbed_request) { stub_request(:get, "#{base_url}/crawl").with(query: {token: token}).to_return( single_crawl_response_body) }
			it "should make a request to /crawl with the token as argument" do
				all
				expect(stubbed_request).to have_been_requested
			end
			it "should return an crawl array " do
				expect(all).to eql([{ foo: 'bar' }])
			end
		end
		context "when asking for a named crawl" do
			let(:named_crawl) { stubbed_request; subject.single_crawl name: name, onlyProcessIfNew: 0, apiUrl: custom }
			let(:stubbed_request) { stub_request(:get, "#{base_url}/crawl").with(query: { name: name, token: token, onlyProcessIfNew: 0, apiUrl: custom.to_crawl_api_url}).to_return single_crawl_response_body() }
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
		context "when pausing or unpausing a named crawl" do
			let(:pause) { stubbed_pause_request; subject.pause name: name }
			let(:unpause) { stubbed_unpause_request; subject.unpause name: name }
			let(:stubbed_pause_request) { stub_request(:get, "#{base_url}/crawl").with(query: { name: name, token: token, pause: 1 }).to_return(single_crawl_response_body) }
			let(:stubbed_unpause_request) { stub_request(:get, "#{base_url}/crawl").with(query: { name: name, token: token, pause: 0 }).to_return(single_crawl_response_body) }
			it "should make the request to pause it" do
				pause
				expect(stubbed_pause_request).to have_been_requested
			end
			it "should make the request to unpause it" do
				unpause
				expect(stubbed_unpause_request).to have_been_requested
			end
		end
		context "when restarting a named crawl" do
			let(:restart) { stubbed_request; subject.restart name: name }
			let(:stubbed_request) { stub_request(:get, "#{base_url}/crawl").with(query: { name: name, token: token, restart: 1 }).to_return(single_crawl_response_body) }
			it "should make the request to restart it" do
				restart
				expect(stubbed_request).to have_been_requested
			end
		end
		context "when requesting a crawls result" do
			let(:result) { stubbed_crawl_request;stubbed_result_request; subject.result name: name }
			let(:test_download_url) { "http://google.com" }
			let(:stubbed_crawl_request) { stub_request(:get, "#{base_url}/crawl").with(query: { name: name, token: token}).to_return(body: "{\"jobs\":[{\"downloadJson\":\"#{test_download_url}\"}]}") }
			let(:stubbed_result_request) { stub_request(:get, test_download_url).to_return(body: "[{'f':'b'}]") }
			it "should make the two requests to get the results" do
				result
				expect(stubbed_crawl_request).to have_been_requested
				expect(stubbed_result_request).to have_been_requested
			end
		end
		describe "if diffbots response is an error" do
			let(:error_from_diffbot) { { error: "Your token has exceeded the allowed number of calls, or has otherwise been throttled for API abuse.", errorCode: 429 }.to_json }
			let(:stubbed_request) { stub_request(:get, /#{base_url}\/crawl*/).to_return(body: error_from_diffbot) }
			shared_examples_for "an error" do
				it "and raise an DiffbotError" do
					expect{raiser}.to raise_error DiffbotError
				end
			end
			context "on all" do
				let(:raiser) { stubbed_request;subject.all; }
				it_should_behave_like "an error"
			end
			context "on single_crawl" do
				let(:raiser) { stubbed_request;subject.single_crawl name: name; }
				it_should_behave_like "an error"
			end
			context "on delete" do
				let(:raiser) { stubbed_request;subject.delete name: name; }
				it_should_behave_like "an error"
			end
			context "on pause" do
				let(:raiser) { stubbed_request;subject.pause name: name; }
				it_should_behave_like "an error"
			end
			context "on unpause" do
				let(:raiser) { stubbed_request;subject.unpause name: name; }
				it_should_behave_like "an error"
			end
			context "on restart" do
				let(:raiser) { stubbed_request;subject.restart name: name; }
				it_should_behave_like "an error"
			end
			context "on result" do
				let(:raiser) { stubbed_request;subject.result name: name; }
				it_should_behave_like "an error"
			end
		end
	end
end
