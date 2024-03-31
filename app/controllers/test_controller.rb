class TestController < ApplicationController
  def index
    render json: { message: "this is a test message from the API" }
  end
end
