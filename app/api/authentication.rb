module Api
  module Authentication

    def self.registered(app)
      app.post '/v1/account/login' do
        {}.to_json
      end
    end


  end
end