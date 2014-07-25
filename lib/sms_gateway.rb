# require 'json'
# class SMSGateway

#   def initialize
#       @login = ENV['SMS_GATEWAY_LOGIN']
#       @password = ENV['SMS_GATEWAY_PASSWORD']
#       @base_uri = ENV['SMS_GATEWAY_URL']
#       # @max_segment = 160 #ENV['SMS_MAX_SEGMENT_LENGTH'].to_i
#       # @split = false #ENV['SPLIT_SMS']
#     end

#     def add_pluses msg
#       msg = msg.gsub(" ", "+")
#     end

#     def send to, message
#       # body = {"target" => "kenyaOrient",
#       #         "msisdn" => to,
#       #         "text" => message,
#       #         "login" => @login,
#       #         "pass" => @password
#       #       }
#       # HTTParty.post(@base_uri, body)
#       begin
#         response = HTTParty.get("#{@base_uri}?target=kenyaOrient&msisdn=#{to}&text=#{add_pluses(message)}&login=#{@login}&pass=#{@password}")
#         puts ">>>>>> #{response}"
#       rescue Exception => e
#         puts e.backtrace
#       end
#     end
# end
require 'json'
class SMSGateway

  def initialize
    @service_id = ENV['SMS_GATEWAY_SERVICE_ID']
    @channel_id = ENV['SMS_GATEWAY_CHANNEL_ID']
    @password = ENV['SMS_GATEWAY_PASSWORD']
    @base_uri = ENV['SMS_GATEWAY_URL']
    @max_segment = 160 #ENV['SMS_MAX_SEGMENT_LENGTH'].to_i
    @split = false #ENV['SPLIT_SMS']
  end

  def send to, message
    begin
      segments = [message]
      if @split
        segments = split_message(message)
      end

      segments.each do |txt|
        xml = create_message to, txt
        response = ""
        puts ">>> Sent: #{txt} to #{to}"

        # if Rails.env == "production"
          options = {
              :body => xml,
              :headers => { "content-type" => "text/xml;charset=utf8" }
          }

          response = HTTParty.post( @base_uri, options)
          # puts ">>>> before sleep"
          # sleep(1.seconds)
          # puts ">>>> after sleep"
        # else
        #   response = {"methodResponse"=>
        #     {"params"=>
        #       {"param"=>
        #         {"value"=>
        #           {"struct"=>
        #             {"member"=>
        #               {"name"=>"Identifier", "value"=>{"string"=>"365d6a84"}}}}}}}}
        # # end
        # resp = response.to_s
        # receipt_id = response["methodResponse"]["params"]["param"]["value"]["struct"]["member"]["value"]["string"]
        # Sms.create! :to => to, :text => txt, :request => xml,  :response => resp, :receipt_id => receipt_id
      end
    rescue
    #  Do nothing
    end
  end
  
  def should_split_message message
    message.length > @max_segment
  end
  
  def split_message message
    message.chars.each_slice(@max_segment).map(&:join)
  end

  def create_message to, message
     xml = "<?xml version=\"1.0\"?>
      <methodCall>
        <methodName>EAPIGateway.SendSMS</methodName>
        <params>
          <param>
            <value>
              <struct>
                <member>
                  <name>Numbers</name>
                  <value>#{to}</value>
                </member>
                <member>
                  <name>SMSText</name>
                  <value>#{message}</value>
                </member>
                <member>
                  <name>Password</name>
                  <value>#{@password}</value>
                </member>
                <member>
                  <name>Service</name>
                  <value>
                    <int>#{@service_id}</int>
                  </value>
                </member>
                <member>
                  <name>Receipt</name>
                  <value>#{ENV['SMS_USE_RECEIPTS']}</value>
                </member>
                <member>
                  <name>Channel</name>
                  <value>#{@channel_id}</value>
                </member>
                <member>
                  <name>Priority</name>
                  <value>Urgent</value>
                </member>
                <member>
                  <name>MaxSegments</name>
                  <value>
                    <int>2</int>
                  </value>
                </member>
              </struct>
            </value>
          </param>
        </params>
      </methodCall>"
      xml
  end
end