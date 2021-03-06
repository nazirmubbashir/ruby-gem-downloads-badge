require_relative './helper'
# middleware used only in development for testing purposes
class RequestMiddleware
  include Helper

  # Method that is used to debug requests to API's
  # The method receives the request object and prints it content to console
  #
  # @param [EventMachine::HttpRequest] client The Http request made to an API
  # @param [Hash] head The http headers sent to API
  # @param [String, nil] body The body sent to API
  # @return [Array<Hash,String>] Returns the http headers and the body
  def request(client, head, body)
    puts "############## HTTP REQUEST  #####################\n"
    puts JSON.pretty_generate(
      request_cookies: request_cookies,
      headers: head,
      url: client.req.uri,
      body: body,
      object: client.inspect
    )
    [head, body]
  end

  # Method that is used to debug responses from API's
  # The method receives the response object and prints it content to console
  #
  # @param [EventMachine::HttpResponse] resp The Http response received from API
  # @return [EventMachine::HttpResponse]
  def response(resp)
    puts "############## HTTP RESPONSE  #####################\n"
    headers = resp.response_header
    puts JSON.pretty_generate(
      request_cookies: request_cookies,
      headers: headers,
      status: headers.status,
      body: force_utf8_encoding(resp.response.to_s.inspect)
    )
    resp
  end
end
