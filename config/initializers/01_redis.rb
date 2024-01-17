$alfred = ConnectionPool.new(size: 5, timeout: 1) do
  redis = if Rails.env.test?
            MockRedis.new
          else
            Redis.new(Redis::Config.app.merge(ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE }))
          end
  Redis::Namespace.new('alfred', redis: redis, warning: true)
end

$velma = ConnectionPool.new(size: 5, timeout: 1) do
  config = if Rails.env.test?
             MockRedis.new
           else
             Redis.new(Redis::Config.app.merge(ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE }))
           end
  Redis::Namespace.new('velma', redis: config, warning: true)
end
