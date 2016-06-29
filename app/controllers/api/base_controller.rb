module API
  class BaseController < ::ApplicationController
    respond_to :json
    protect_from_forgery with: :null_session
    self.responder = Metova::Responder
  end
end
