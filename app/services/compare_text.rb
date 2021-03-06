# frozen_string_literal: true

require 'uri'
require 'net/http'
require 'openssl'

class CompareText
  include Callable
  attr_reader :solution_text, :submitted_text, :url

  def initialize(solution_text, submitted_text)
    @solution_text = solution_text
    @submitted_text = submitted_text
    @url = URI('https://api.twinword.com/api/v6/text/similarity/')
  end

  def call
    response = http.request(request)
    response.body
  end

  private

  def request
    request = Net::HTTP::Post.new(url)
    request['x-rapidapi-host'] = 'twinword-text-similarity-v1.p.rapidapi.com'
    request['x-rapidapi-key'] = ENV['TWINWORLD_API_KEY']
    request['content-type'] = 'application/x-www-form-urlencoded'
    body = URI.encode_www_form(
      [['text1', solution_text], ['text2', submitted_text]]
    )
    request.body = body
    request
  end

  def http


    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    http
  end
end
