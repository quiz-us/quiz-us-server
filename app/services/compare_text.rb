# frozen_string_literal: true

require 'uri'
require 'net/http'
require 'openssl'

class CompareText
  include Callable

  def initialize(solution_text, submitted_text)
    url = URI('https://api.twinword.com/api/v6/text/similarity/')

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    @request = Net::HTTP::Post.new(url)
    @request['x-rapidapi-host'] = 'twinword-text-similarity-v1.p.rapidapi.com'
    @request['x-rapidapi-key'] = ENV['TWINWORLD_API_KEY']
    @request['content-type'] = 'application/x-www-form-urlencoded'
    body = URI.encode_www_form(
      [['text1', solution_text], ['text2', submitted_text]]
    )
    @request.body = body
    response = http.request(@request)
    puts response.body
  end

  def call; end
end
