require 'spec_helper'

module DiffbotSimple::V2
	describe Article do
		let(:client) { Client.new token: token }
		let(:url) { "http://foo.bar" }
		let(:article) { client.article }
		let(:single_article_response) do 
			{ 
				body:  
					{ :type=>"article", :icon=>"http://www.diffbot.com/favicon.ico", :title=>"Diffbot's New Product API Teaches Robots to Shop Online", :author=>"John Davi"}.to_json 
			} 
		end

		shared_examples_for "an article request" do
			it "should make a valid request to the article api" do
				stubbed_request
				subject
				expect(stubbed_request).to have_been_requested
			end
			it "should return the response body as an symbolized hash" do
				stubbed_request
				expect(subject).to eql JSON.parse(single_article_response[:body], symbolize_names: true)
			end
		end
		context "when asking for a single article with no additional options" do
			let(:subject) { article.single_article url: url }
			let(:stubbed_request) { stub_request(:get, "#{base_url}/article").with(query: {token: token, url: url }).to_return(single_article_response) }
			it_should_behave_like "an article request"
		end

		context "when asking for a single article with some additional options" do
			let(:subject) { article.single_article url: url, fields: "meta,querystring,images(*)" }
			let(:stubbed_request) { stub_request(:get, "#{base_url}/article").with(query: {token: token, url: url, fields: "meta,querystring,images(*)" }).to_return(single_article_response) }
			it_should_behave_like "an article request"
		end
		context "when asking for a single article with custom headers" do
			let(:subject) { article.single_article url: url, custom_headers: { "X-Forward-User-Agent" => "I AM CHROME" } }
			let(:stubbed_request) { stub_request(:get, "#{base_url}/article").with(query: {token: token, url: url }, headers: { "X-Forward-User-Agent" => "I AM CHROME" }).to_return(single_article_response) }
			it_should_behave_like "an article request"
		end

		context "when posting a body directly to analyze" do
			let(:body) { "<html><fake><body>" }
			let(:subject) { article.single_article url: url, body: body }
			let(:stubbed_request) { stub_request(:post, "#{base_url}/article").with(query: {token: token, url: url }, body: body).to_return(single_article_response) }
			it_should_behave_like "an article request"
		end
	end
end