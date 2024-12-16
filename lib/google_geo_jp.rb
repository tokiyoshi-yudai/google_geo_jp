require "google_geo_jp/version"

module GoogleGeoJp
  require "json"
  require "net/https"
  require "uri"
  require 'active_support/all'

  def self.get_geo(key, postal_code)
    query = {
      address: postal_code,
      key: key
    }
    query = query.to_query
    uri = URI("https://maps.googleapis.com/maps/api/geocode/json?language=ja&components=country:JP&" + query)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    req = Net::HTTP::Get.new(uri)
    res = http.request(req)
    res_data = JSON.parse(res.body)

    # DBに同じpostal_codeがある場合は流用する
    res_data["results"][0]["geometry"]["location"]
  end

  def self.travel_time(key1, key2, start_place, end_place)
    query = {
      key: key2,
      origin: start_place, #緯度, 経度
      destination: end_place, #緯度, 経度
      mode: "driving",
      avoid: "tolls" # 回避: 有料道路
    }
    query = query.to_query
    uri = URI("https://maps.googleapis.com/maps/api/directions/json?language=ja&" + query)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    req = Net::HTTP::Get.new(uri)
    res = http.request(req)
    res_data = JSON.parse(res.body)
    duration_minutes = res_data.dig("routes")&.first.dig("legs")&.first.dig("duration", "value") / 60
    duration_minutes
  end

  def self.get_location_as_string(key, postal_code)
    lat, lon = get_geo(key, postal_code).values
    lat.to_s + "," + lon.to_s
  end
end
