class ApplicationController < ActionController::API
  include ActionController::Cookies
  include UserAuth::Aunthenticator
end
