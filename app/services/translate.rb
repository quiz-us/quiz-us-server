# frozen_string_literal: true

require 'google/cloud/translate'

class Translate
  attr_reader :g_translate, :language

  def initialize(language)
    @g_translate = Google::Cloud::Translate.new(
      version: :v2,
      key: ENV['TRANSLATE_KEY']
    )
    @language = language
  end

  def translate(text)
    translation = g_translate.translate text, to: language
    translation.text
  end
end
