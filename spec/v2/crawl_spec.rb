require 'spec_helper'
module DiffbotSimple::V2
	describe Crawl do
		let(:crawl_api) { double("crawl_api") }
		let(:name) { "test" }
		let(:subject) { Crawl.new crawl_api: crawl_api, name: name}
		before(:each) { expect(crawl_api).to receive(:single).with(name: name).and_return({ notifyEmail: nil, downloadJson: "download_url" }) }
		context "when pausing" do
			it "should send pause = 1 to crawl api" do
				expect(crawl_api).to receive(:single).with(name: name, pause: 1).and_return({})
				subject.pause
			end
		end
		context "when unpausing" do
			it "should send pause = 0 to crawl api" do
				expect(crawl_api).to receive(:single).with(name: name, pause: 0).and_return({})
				subject.unpause
			end
		end
		context "when deleting" do
			it "should send delete = 1 to crawl api" do
				expect(crawl_api).to receive(:single).with(name: name, delete: 1).and_return({})
				subject.delete!
			end
		end
		context "when restarting" do
			it "should send restart = 1 to crawl api" do
				expect(crawl_api).to receive(:single).with(name: name, restart: 1).and_return({})
				subject.restart
			end
		end
 		context "when downloading results" do
			it "should call for results on crawl api" do
				expect(crawl_api).to receive(:results).with(url: "download_url").and_return([])
				subject.results
			end
		end
		context "when updating general parameters" do
			it "should send these to crawl api" do
				expect(crawl_api).to receive(:single).with(name: name, notifyEmail: "foo@b.ar").and_return({})
				subject.notifyEmail "foo@b.ar"
			end
			it "should even do it as an setter" do
				expect(crawl_api).to receive(:single).with(name: name, notifyEmail: "foo@b.ar").and_return({})
				subject.notifyEmail = "foo@b.ar"
			end
		end
		context "when updating several properties at once" do
			it "should send them to crawl api" do
				expect(crawl_api).to receive(:single).with(name: name, notifyEmail: "foo@b.ar", repeat: 7.0).and_return({})
				subject.update notifyEmail: "foo@b.ar", repeat: 7.0
			end
		end
	end
end