require 'rails_helper'

  RSpec.describe "Cats", type: :request do
    describe "GET /index" do
      it "gets a list of cats" do
        Cat.create(
          name: 'Felix',
          age: 2,
          enjoys: 'Walks in the park',
          image: 'https://images.unsplash.com/photo-1529778873920-4da4926a72c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1036&q=80'
        )

        # Make a request
        get '/cats'

        cat = JSON.parse(response.body)
        expect(response).to have_http_status(200)
        expect(cat.length).to eq 1
     end
  end

  describe "POST /create" do
    it "creates a cat" do
      # The params we are going to send with the request
      cat_params = {
        cat: {
          name: 'Buster',
          age: 4,
          enjoys: 'Meow Mix, and plenty of sunshine.',
          image: 'https://images.unsplash.com/photo-1529778873920-4da4926a72c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1036&q=80'
        }
      }

      # Send the request to the server
      post '/cats', params: cat_params

      # Assure that we get a success back
      expect(response).to have_http_status(200)

      # Look up the cat we expect to be created in the db
      cat = Cat.first

      # Assure that the created cat has the correct attributes
      expect(cat.name).to eq 'Buster'
    end
  end

  it "doesn't create a cat without a name" do
    cat_params = {
      cat: {
        age: 2,
        enjoys: 'Walks in the park',
        image: 'https://images.unsplash.com/photo-1529778873920-4da4926a72c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1036&q=80'
      }
    }
    # Send the request to the  server
    post '/cats', params: cat_params
    # expect an error if the cat_params does not have a name
    expect(response.status).to eq 422
    # Convert the JSON response into a Ruby Hash
    json = JSON.parse(response.body)
    # Errors are returned as an array because there could be more than one, if there are more than one validation failures on an attribute.
    expect(json['name']).to include "can't be blank"
  end

  it "doesn't create a cat without an age" do
    cat_params = {
      cat: {
        name: 'Sylvester',
        enjoys: 'Walks in the park',
        image: 'https://images.unsplash.com/photo-1529778873920-4da4926a72c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1036&q=80'
      }
    }
    # Send the request to the  server
    post '/cats', params: cat_params
    # expect an error if the cat_params does not have a name
    expect(response.status).to eq 422
    # Convert the JSON response into a Ruby Hash
    json = JSON.parse(response.body)
    # Errors are returned as an array because there could be more than one, if there are more than one validation failures on an attribute.
    expect(json['age']).to include "can't be blank"
  end

  it "doesn't create a cat without enjoys" do
    cat_params = {
      cat: {
        name: 'Thomas OMalley',
        age: 2,
        image: 'https://images.unsplash.com/photo-1529778873920-4da4926a72c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1036&q=80'
      }
    }
    # Send the request to the  server
    post '/cats', params: cat_params
    # expect an error if the cat_params does not have a name
    expect(response.status).to eq 422
    # Convert the JSON response into a Ruby Hash
    json = JSON.parse(response.body)
    # Errors are returned as an array because there could be more than one, if there are more than one validation failures on an attribute.
    expect(json['enjoys']).to include "can't be blank"
  end
  
  it "doesn't create a cat without an image" do
    cat_params = {
      cat: {
        name: 'Garfield',
        age: 2,
        enjoys: 'Walks in the park',
      }
    }
    # Send the request to the  server
    post '/cats', params: cat_params
    # expect an error if the cat_params does not have a name
    expect(response.status).to eq 422
    # Convert the JSON response into a Ruby Hash
    json = JSON.parse(response.body)
    # Errors are returned as an array because there could be more than one, if there are more than one validation failures on an attribute.
    expect(json['image']).to include "can't be blank"
  end
end