require 'json'
class SMSGateway

  def initialize
      @login = ENV['SMS_GATEWAY_LOGIN']
      @password = ENV['SMS_GATEWAY_PASSWORD']
      @base_uri = ENV['SMS_GATEWAY_URL']
      # @max_segment = 160 #ENV['SMS_MAX_SEGMENT_LENGTH'].to_i
      # @split = false #ENV['SPLIT_SMS']
    end

    def send to, message
      begin
        puts HTTParty.get("#{@base_uri}?target=kenyaOrient&msisdn=#{to}&text=#{message}&login=#{@login}&pass=#{@password}")
      rescue Exception => e
        # puts e.backtrace
      end
    end
end