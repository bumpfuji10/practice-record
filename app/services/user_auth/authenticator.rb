module UserAuth
  module Authenticator

    def authenticate_user
      current_user.presence || unauthorized_user
    end

    def delete_cookie
      return if cookies[token_access_key].blank?
      cookies.delete(token_access_key)
    end

    private

    # リクエストヘッダーからトークンを取得
    def token_from_request_headers
      request.headers["Authorization"]&.split&.last
    end

    # クッキーのオブジェクトキー(config/initializers/user_auth.rb)
    def token_access_key
      UserAuth.token_access_key
    end

    # トークンの取得
    def token
      token_from_request_headers || config[token_access_key]
    end

    def fetch_entity_from_token
      AuthToken.new(token: token).entity_for_user
    rescue ActiveRecord::RecordNotFound, JWT::DecodeError, JWT::EncodeError
      nil
    end

    def current_user
      return if token.blank?
      @_current_user ||= fetch_entity_from_token
    end

    def unauthorized_user
      head(:unauthorized) && delete_cookie
    end
  end
end
