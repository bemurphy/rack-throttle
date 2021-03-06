module Rack; module Throttle
  class TimeWindow < Limiter
    ##
    # Returns `true` if fewer than the max number of requests permitted
    # for the current window of time have been made.
    #
    # @param  [Rack::Request] request
    # @return [Boolean]
    def allowed?(request)
      count = cache_get(key = cache_key(request)).to_i + 1 rescue 1
      allowed = count <= max_per_window
      begin
        cache_set(key, count)
        allowed
      rescue => e
        allowed = true
      end
    end
  end
end; end