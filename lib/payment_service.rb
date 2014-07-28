require 'digest/md5'
class PaymentService

  def initialize
    @gateway_url = ENV['PAYMENT_GATEWAY_URL']
    @username = ENV['PAYMENT_GATEWAY_USER']
    @pass = ENV['PAYMENT_GATEWAY_PASSWORD']
    @client = Savon::Client.new(@gateway_url)
    # client.wsdl.soap_actions
  end

  def prepare_payment trace, amount, number
    amount_to_s = sprintf('%.2f', amount)
    # MD5(userName+ trace+ currencyToString(Amount)+secret)
    @pass = Digest::MD5.hexdigest(@username + trace + amount_to_s + @pass)
    puts @pass
    # response = @client.call :prepare_payment, message: { "username" => @username,
    # "pass" => @pass, "trace" => trace, "amount" => amount, "phone" => number }
     xml = "<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:bul='http://www.jambopay.com/bulkpayservice/' xmlns:co='http://schemas.datacontract.org/2004/07/co.ke.webtribe.botmpesa'>
        <soapenv:Header/>
        <soapenv:Body>
           <bul:PreparePayment>
              <!--Optional:-->
              <bul:username>#{@username}</bul:username>
              <!--Optional:-->
              <bul:pass>#{@pass}</bul:pass>
              <!--Optional:-->
              <bul:trace>#{trace}</bul:trace>
              <!--Optional:-->
              <bul:amount>#{amount}</bul:amount>
              <!--Optional:-->
              <bul:amountDistributionList>
                 <!--Zero or more repetitions:-->
                 <co:JPPayBucket>
                    <!--Optional:-->
                    <co:Amount>#{amount}</co:Amount>
                    <!--Optional:-->
                    <co:Phone>#{number}</co:Phone>
                    <!--Optional:-->
                    <co:Status>true</co:Status>
                 </co:JPPayBucket>
              </bul:amountDistributionList>
           </bul:PreparePayment>
        </soapenv:Body>
     </soapenv:Envelope>
     "

     response = @client.request :prepare_payment do
       soap.xml = xml
     end
     response
  end
  def create_payment transaction_id, approval_code
    # pass=MD5(userName+transactionID+ approvalCode +secret)
    @pass = Digest::MD5.hexdigest(@username + transaction_id + approval_code + @pass)
    # client.request :prepare_payment, body: { "username" => @username,
    # "pass" => @pass, "transaction_id" => transaction_id, "approval_code" => approval_code }
     xml = "<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:bul='http://www.jambopay.com/bulkpayservice/'>
   <soapenv:Header/>
   <soapenv:Body>
      <bul:CreatePayment>
         <!--Optional:-->
         <bul:username>#{@username}</bul:username>
         <!--Optional:-->
         <bul:pass>#{@pass}</bul:pass>
         <!--Optional:-->
         <bul:transactionID>#{transaction_id}</bul:transactionID>
         <!--Optional:-->
         <bul:approvalCode>#{approval_code}</bul:approvalCode>
      </bul:CreatePayment>
   </soapenv:Body>
</soapenv:Envelope>"
  
    response = @client.request :create_payment do
      soap.xml = xml
    end
    response
  end

  def check_balance
    # response = @client.call :get_account_balance, message: { "username" => @username,
    # "pass" => @pass }
    xml = "<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:bul='http://www.jambopay.com/bulkpayservice/'>
     <soapenv:Header/>
     <soapenv:Body>
        <bul:GetAccountBalance>
           <!--Optional:-->
           <bul:username>#{@username}</bul:username>
           <!--Optional:-->
           <bul:timestamp>#{Time.now.to_i}</bul:timestamp>
           <!--Optional:-->
           <bul:pass>#{@pass}</bul:pass>
        </bul:GetAccountBalance>
     </soapenv:Body>
  </soapenv:Envelope>"

    response = @client.request :get_account_balance do
      soap.xml = xml
    end
    response
  end
end