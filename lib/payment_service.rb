require 'digest/md5'
class PaymentService

  def initialize
    @gateway_url = ENV['PAYMENT_GATEWAY_URL']
    @username = ENV['PAYMENT_GATEWAY_USER']
    @pass = ENV['PAYMENT_GATEWAY_PASSWORD']
    @client = Savon.client(wsdl: @gateway_url)
    # client.wsdl.soap_actions
  end

  def prepare_payment trace, amount, number
    amount_to_s = sprintf('%.2f', amount)
    @pass = Digest::MD5.hexdigest(@username + trace + amount_to_s + @pass)
    response = @client.call :prepare_payment, message: { "username" => @username,
    "pass" => @pass, "trace" => trace, "amount" => amount, "phone" => number }
#      xml = '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">
# <s:Body>
# <PreparePayment xmlns="http://www.jambopay.com/bulkpayservice/">
# <username>yourusername</username>
# <pass>yourpassword</pass>
# <trace>12345</trace>
# <amount>220</amount>
# <amountDistributionList
# xmlns:a="http://schemas.datacontract.org/2004/07/co.ke.webtribe.botmpesa"
# xmlns:i="http://www.w3.org/2001/XMLSchema-instance">
# <a:JPPayBucket>
# <a:Amount>110</a:Amount>
# <a:Phone>0720000000</a:Phone>
# <a:Status i:nil="true"/>
# </a:JPPayBucket>
# <a:JPPayBucket>
# <a:Amount>110</a:Amount>
# <a:Phone>254720000000</a:Phone>
# <a:Status i:nil="true"/>
# </a:JPPayBucket>
# </amountDistributionList>
# </PreparePayment>
# </s:Body>
# </s:Envelope>
# '
#       xml
  end
  def create_payment transaction_id, approval_code
    @pass = Digest::MD5.hexdigest(@username + transaction_id + ap + @pass)
    client.request :prepare_payment, body: { "username" => @username,
    "pass" => @pass, "transaction_id" => transaction_id, "approval_code" => approval_code }
#      xml = '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">
# <s:Body>
# <CreatePayment xmlns="http://www.jambopay.com/bulkpayservice/">
# <username>yourusername</username>
# <pass>yourpassword</pass>
# <transactionID>5</transactionID>
# <approvalCode>0</approvalCode>
# </CreatePayment>
# </s:Body>
# </s:Envelope>

# '
#       xml
  end

  def check_balance
    response = @client.call :get_account_balance, message: { "username" => @username,
    "pass" => @pass }
#     '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:bul="http://www.jambopay.com/bulkpayservice/">
#    <soapenv:Header/>
#    <soapenv:Body>
#       <bul:GetAccountBalance>
#          <!--Optional:-->
#          <bul:username>?</bul:username>
#          <!--Optional:-->
#          <bul:timestamp>?</bul:timestamp>
#          <!--Optional:-->
#          <bul:pass>?</bul:pass>
#       </bul:GetAccountBalance>
#    </soapenv:Body>
# </soapenv:Envelope>'
  end
end