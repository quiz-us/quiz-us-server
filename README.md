# Quiz Us Server

## RSwag Documentation

[RSwag](https://github.com/domaindrivendev/rswag) is used to test API requests and to document the API.

Steps to writing specs that conform to RSwag expectations:

### Start the `describe` block

Example:

```rb

describe 'Teacher Registrations API', type: :request, swagger_doc: 'v1/swagger.json' do
  # specs go here
end

```

Note the `type: :request` and the `swagger_doc: 'v1/swagger.json'` parameters.

### Define the API path that's being tested

Example for creating a new teacher:

```rb

describe 'Teacher Registrations API', type: :request, swagger_doc: 'v1/swagger.json' do
  path '/teachers' do
    # specs for specific actions for this path go here
  end
end

```

### Define the different HTTP verbs that are available for the specified API path

Example:

```rb

describe 'Teacher Registrations API', type: :request, swagger_doc: 'v1/swagger.json' do
  path '/teachers' do
    post 'Registers a new teacher' do
      # specs go here
    end

    delete 'Deletes a teacher' do
      # specs go here
    end
  end
end

```

### Write tests

In order for RSwag to generate swagger docs, your specs need to have the following:

#### Definition of API request metadata (ie. tags, data types, parameter)

```rb
describe 'Teacher Registrations API', type: :request, swagger_doc: 'v1/swagger.json' do
  path '/teachers' do
    post 'Registers a new teacher' do
      tags 'Teacher Sign In'
      consumes 'application/json'
      produces 'application/json'
      parameter in: :body, schema: {
        type: :object,
        properties: {
          teacher: {
            type: :object,
            properties: {
              email: { type: :string },
              password: { type: :string }
            }
          }
        },
        required: ['email', 'password']
      }
    end

    delete 'Deletes a teacher' do
      # specs go here
    end
  end
end
```

#### Definition of the `response` block

```rb
describe 'Teacher Registrations API', type: :request, swagger_doc: 'v1/swagger.json' do
  path '/teachers' do
    post 'Registers a new teacher' do
      # ...metadata here

      response '200', 'Success' do
        # specs go here
      end
    end

    delete 'Deletes a teacher' do
      # specs go here
    end
  end
end
```

### Swaggerize

Once you are satisified, generate documentation based on your specs by running:

`be rake rswag:specs:swaggerize`

Then, navigate to `/api-docs` (ie. `http://localhost:3000/api-docs) to see the
API's documentation.
