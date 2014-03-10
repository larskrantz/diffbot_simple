require 'spec_helper'

module DiffbotSimple
	describe Symbolize do
		let(:test_data) { MultiJson.load File.read("spec/serialize_test_data.json") }
		let(:subject) { Symbolize.symbolize test_data }
		context "when symbolizing the test data" do
			it "should not raise errors" do
				expect{ subject }.to_not raise_error
			end
			it "should have :nextPages as an array" do
				expect(subject[:nextPages]).to be_a Array
			end
		end	
	end

end