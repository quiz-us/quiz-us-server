def generate_rich_text(text)
  {
    object: 'value',
    document: {
      object: 'document',
      data: {},
      nodes: [{
        object: 'block',
        type: 'line',
        data: {},
        nodes: [{ object: 'text', text: text, marks: [] }]
      }]
    }
  }.to_json
end
