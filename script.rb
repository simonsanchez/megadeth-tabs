# frozen_string_literal

require 'nokogiri'
require 'open-uri'
require "down"
require "fileutils"

BASE_URL = 'https://www.eltontabs.com'
DEST_DIR = "#{__dir__}/downloads"
S3_URL = 'tabarchive.s3.us-east-2.amazonaws.com'

url = 'https://www.eltontabs.com/albumList?artistId=2'
document = Nokogiri::HTML.parse(URI.open(url))

anchors = document.xpath('//a')

dir_num = 0
anchors.each do |a|
  if a[:href].start_with?("/songList")
    puts "Downloading album: #{dir_num}"
    album_url =  BASE_URL + a[:href]

    album_document = Nokogiri::HTML.parse(URI.open(album_url))
    album_anchors = album_document.xpath('//a')

    album_dir = "#{DEST_DIR}/#{dir_num}"
    FileUtils.mkdir_p(album_dir)

    album_anchors.each do |aa|
      if aa[:href].include?(S3_URL) && aa[:href].end_with?('.txt', '.pdf')
        tempfile = Down.download(aa[:href])
        FileUtils.mv(tempfile.path, "#{album_dir}/#{tempfile.original_filename}")
      end
    end

    dir_num += 1
  end
end

puts 'Done!'
