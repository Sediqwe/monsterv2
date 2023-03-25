class IpBlocker
    BLOCKED_IP_PREFIX = '181.191.171'
    p "indul"
    def initialize(app)
      @app = app
    end
  
    def call(env)
      request = Rack::Request.new(env)
      if request.ip.start_with?(BLOCKED_IP_PREFIX)
        [403, {}, ['Access Forbidden']]
      else
        @app.call(env)
      end
    end
  end