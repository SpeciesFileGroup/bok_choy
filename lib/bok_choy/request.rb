require_relative "faraday" # !! Potential ruby 3.0 difference in module loading? relative differs from Serrano
require "faraday/follow_redirects"
require_relative "utils"

module BokChoy

  class Request
    attr_accessor :endpoint
    attr_accessor :q
    attr_accessor :verbose
    attr_accessor :item_id
    attr_accessor :page_num

    attr_accessor :options

    def initialize(**args)
      @endpoint = args[:endpoint]
      @verbose = args[:verbose]
      @q = args[:q]
      @item_id = args[:item_id]
      @page_num = args[:page_num]
      @json = args[:json].to_json
      @options = args[:options] # TODO: not added at bok_choy.rb
    end

    def perform

      args = {
        json: @json,
        item_id: @item_id,
        page_num: @page_num
      }
      opts = args.delete_if { |_k, v| v.nil? }
      opts = args.delete_if { |_k, v| v == 'null' }

      Faraday::Utils.default_space_encoding = "+"

      conn = if verbose
               Faraday.new(url: BokChoy.base_url) do |f|
                 f.response :logger
                 f.use Faraday::BokChoyErrors::Middleware
                 f.adapter Faraday.default_adapter
               end
             else
               Faraday.new(url: BokChoy.base_url) do |f|
                 f.use Faraday::BokChoyErrors::Middleware
                 f.adapter Faraday.default_adapter
               end
             end

      conn.headers['Accept'] = 'application/json,*/*'
      conn.headers[:user_agent] = make_user_agent
      conn.headers["X-USER-AGENT"] = make_user_agent
      conn.headers['Content-Type'] = 'application/json'

      if %w[name_refs].include? endpoint
        res = conn.post(endpoint, opts[:json])
      else
        res = conn.get(endpoint, opts)
      end

      # Handles endpoints that do not return JSON
      begin
        MultiJson.load(res.body)
      rescue MultiJson::ParseError
        res.body
      end
      
    end
  end
end
