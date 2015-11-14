#!/bin/env ruby
# encoding: utf-8

require 'scraperwiki'
require 'wikidata/fetcher'
require 'nokogiri'
require 'open-uri'
require 'pry'

def noko_for(url)
  Nokogiri::HTML(open(url).read) 
end

def wikinames_from(url)
  noko = noko_for(url)
  names = noko.xpath('//table[.//th[contains(.,"MP")]]//tr[td]//td[2]//a[not(@class="new")]/@title').map(&:text)
  raise "No names found in #{url}" if names.count.zero?
  return names
end

def fetch_info(names)
  WikiData.ids_from_pages('en', names.flatten.compact.uniq).each do |name, id|
    data = WikiData::Fetcher.new(id: id).data rescue nil
    unless data
      warn "No data for #{p}"
      next
    end
    data[:original_wikiname] = name
    ScraperWiki.save_sqlite([:id], data)
  end
end

fetch_info(wikinames_from("https://en.wikipedia.org/wiki/List_of_MPs_of_the_National_Assembly_of_Cambodia"))

require 'rest-client'
warn RestClient.post ENV['MORPH_REBUILDER_URL'], {} if ENV['MORPH_REBUILDER_URL']
