module API
  class SessionsController < ::Devise::SessionsController
    include Metova::Devise::Controller

    def respond_with(resource, options = {})
      super resource, options.merge(serializer: UserWithTokenSerializer)
    end
  end
end
