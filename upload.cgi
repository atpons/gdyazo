#!/usr/bin/env ruby

require "google_drive"
require "cgi"
require "digest/md5"
require "net/http"
require "uri"

def expand_url(url)
  begin
    response = Net::HTTP.get_response(URI.parse(url))
  rescue
    return url
  end
  case response
  when Net::HTTPRedirection
    expand_url(response['location'])
  else
    url
  end
end

session = GoogleDrive::Session.from_config("/opt/config/config.json")

folder = session.collection_by_title("screenshots")

if folder.nil?
  session.root_collection.create_subcollection("screenshots")
end

cgi = CGI.new("html3")

imagedata = cgi.params['imagedata'][0]
hash = Digest::MD5.hexdigest(imagedata.read)

folder.upload_from_io(imagedata ,title="#{hash}.png")

img = folder.file_by_title("#{hash}.png")

img.acl.push({type: "anyone", allow_file_discovery: false, role: "reader"})

cgi.out("text/plain"){expand_url("http://drive.google.com/uc?export=view&id=#{img.id.to_s}")}
