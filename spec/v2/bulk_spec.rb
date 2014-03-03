require 'spec_helper'
module DiffbotSimple::V2
	describe Bulk do
		let(:bulk_api) { double("bulk_api") }
		let(:name) { "test" }
		let(:subject) { Bulk.new bulk_api: bulk_api, name: name }
		context "when pausing" do
			it "should send pause = 1 to bulk api" do
				expect(bulk_api).to receive(:single).with(name: name, pause: 1).and_return({})
				subject.pause
			end
		end
		context "when unpausing" do
			it "should send pause = 0 to bulk api" do
				expect(bulk_api).to receive(:single).with(name: name, pause: 0).and_return({})
				subject.unpause
			end
		end
		context "when deleting" do
			it "should send delete = 0 to bulk api" do
				expect(bulk_api).to receive(:single).with(name: name, delete: 1).and_return({})
				subject.delete!
			end
		end
		context "when updating general parameters" do
			it "should send these to bulk api" do
				expect(bulk_api).to receive(:single).with(name: name, notifyEmail: "foo@b.ar").and_return({})
				subject.notifyEmail "foo@b.ar"
			end
			it "should even do it as an setter" do
				expect(bulk_api).to receive(:single).with(name: name, notifyEmail: "foo@b.ar").and_return({})
				subject.notifyEmail = "foo@b.ar"
			end
		end
		context "when updating several properties at once" do
			it "should send them to bulk api" do
				expect(bulk_api).to receive(:single).with(name: name, notifyEmail: "foo@b.ar", repeat: 7.0).and_return({})
				subject.update notifyEmail: "foo@b.ar", repeat: 7.0
			end
		end
	end
end