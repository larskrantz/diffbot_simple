require 'spec_helper'
module DiffbotSimple::V2
	describe Client do
		let(:fake_bulk_api) { double("bulk_api") }
		let(:fake_crawlbot_api) { double("crawlbot_api") }
		let(:subject) { Client.new token: "FOO_TOKEN", bulk_api: fake_bulk_api, crawlbot_api: fake_crawlbot_api }
		context "when initializing with a token" do
			it "should not raise an error" do
				expect{subject}.to_not raise_error
			end
		end
		context 'when initializing without token' do
			let(:subject) { Client.new }
			it "should raise an ArgumentError" do
				expect{subject}.to raise_error ArgumentError
			end
		end
		context "when asking for bulk, " do
			context "all" do
				let(:all_bulk) { subject.bulk }
				it "should use bulk api" do
			 		expect(fake_bulk_api).to receive(:all).and_return({})
			 		all_bulk
				end
			end
			context "named" do
				let(:named) { subject.bulk name: :foo }
				it "should use bulk api" do
			 		expect(fake_bulk_api).to receive(:single).with({ name: :foo }).and_return({})
			 		named
				end
			end
		end
		context "when asking for crawl, " do
			context "all" do
				let(:all_crawls) { subject.crawl }
				it "should use crawlbot api" do
			 		expect(fake_crawlbot_api).to receive(:all).and_return({})
			 		all_crawls
				end
			end
			context "named" do
				let(:named) { subject.crawl name: :foo }
				it "should use crawlbot api" do
			 		expect(fake_crawlbot_api).to receive(:single).with({ name: :foo }).and_return({})
			 		named
				end
			end
		end
	end
end
