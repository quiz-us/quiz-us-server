# frozen_string_literal: true

require 'google/cloud/translate'

class Translate
  def initialize
    translate = Google::Cloud::Translate.new(
      version: :v2,
      key: ENV['TRANSLATE_KEY']
    )

    translation = translate.translate 'Hello world!', to: 'la'

    puts translation #=> Salve mundi!

    translation.from #=> "en"
    translation.origin #=> "Hello world!"
    translation.to #=> "la"
    translation.text #=> "Salve mundi!"
  end
end
