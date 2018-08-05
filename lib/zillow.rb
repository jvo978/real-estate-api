# frozen_string_literal: true

Dotenv.load

class Zillow
  def search(query)
    zwsid = ENV['ZWSID']
    address_obj = StreetAddress::US.parse(query)
    address = "#{address_obj.number}+#{address_obj.street}+#{address_obj.street_type}&citystatezip=#{address_obj.city}+#{address_obj.state}+#{address_obj.postal_code}"
    uri = URI("http://www.zillow.com/webservice/GetDeepSearchResults.htm?zws-id=#{zwsid}&address=#{address}")
    res = Net::HTTP.get_response(uri).body
    data = JSON.parse(Hash.from_xml(res).to_json)
  end
end
