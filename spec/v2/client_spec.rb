require 'spec_helper'
module DiffbotSimple::V2
	describe Client do
		let(:subject) { Client.new token: "FOO_TOKEN" }
		context "when initializing with a token" do
			it "should not raise an error" do
				expect{subject}.to_not raise_error
			end
			it "should respond to crawlbot" do
				expect(subject).to respond_to :crawlbot
			end
		end
		context 'when initializing without token' do
			let(:subject) { Client.new }
			it "should raise an ArgumentError" do
				expect{subject}.to raise_error ArgumentError
			end
		end
	end
end
