require 'spec_helper'
module DiffbotSimple::V2
	describe Crawl do
		let(:crawlbot_api) { double("crawlbot_api") }
		let(:name) { "test" }
		let(:subject) { Crawl.new crawlbot_api: crawlbot_api, name: name}
		before(:each) { expect(crawlbot_api).to receive(:single).with(name: name).and_return({ notifyEmail: nil, downloadJson: "download_url" }) }
		context "when pausing" do
			it "should send pause = 1 to crawl api" do
				expect(crawlbot_api).to receive(:single).with(name: name, pause: 1).and_return({})
				subject.pause
			end
		end
		context "when unpausing" do
			it "should send pause = 0 to crawl api" do
				expect(crawlbot_api).to receive(:single).with(name: name, pause: 0).and_return({})
				subject.unpause
			end
		end
		context "when deleting" do
			it "should send delete = 1 to crawl api" do
				expect(crawlbot_api).to receive(:single).with(name: name, delete: 1).and_return({})
				subject.delete!
			end
		end
		context "when restarting" do
			it "should send restart = 1 to crawl api" do
				expect(crawlbot_api).to receive(:single).with(name: name, restart: 1).and_return({})
				subject.restart
			end
		end
 		context "when downloading results" do
			it "should call for results on crawl api" do
				expect(crawlbot_api).to receive(:results).with(url: "download_url").and_return([])
				subject.results
			end
		end
		context "when updating general parameters" do
			it "should send these to crawl api" do
				expect(crawlbot_api).to receive(:single).with(name: name, notifyEmail: "foo@b.ar").and_return({})
				subject.notifyEmail "foo@b.ar"
			end
			it "should even do it as an setter" do
				expect(crawlbot_api).to receive(:single).with(name: name, notifyEmail: "foo@b.ar").and_return({})
				subject.notifyEmail = "foo@b.ar"
			end
		end
		context "when asking for current value as method call" do
			it "should return an existing parameter" do
				expect(subject.downloadJson).to eql "download_url"
			end
		end
		context "when asking to refresh" do
			it "should ask api for parameters" do
				expect(crawlbot_api).to receive(:single).with(name: name).and_return({})
				subject.refresh
			end
		end
		context "when updating several properties at once" do
			it "should send them to crawl api" do
				expect(crawlbot_api).to receive(:single).with(name: name, notifyEmail: "foo@b.ar", repeat: 7.0).and_return({})
				subject.update notifyEmail: "foo@b.ar", repeat: 7.0
			end
		end
	end
end