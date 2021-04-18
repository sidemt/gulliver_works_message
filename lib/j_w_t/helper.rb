# frozen_string_literal: true
module JWT
  # JWT Helper
  module Helper
    module_function

    def encode(payload, alg = 'HS256', typ = 'JWT', **opts)
      JWT.encode(payload, Rails.application.secrets.secret_key_base, alg, typ: typ, **opts)
    end

    def decode(token, verify: true, **opts)
      JWT.decode(token, Rails.application.secrets.secret_key_base, verify, **opts)
    end
  end
end
