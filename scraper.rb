#!/bin/env ruby
# encoding: utf-8

require 'wikidata/fetcher'

names = EveryPolitician::Wikidata.wikipedia_xpath( 
  url: 'https://en.wikipedia.org/wiki/List_of_MPs_of_the_National_Assembly_of_Cambodia',
  xpath: '//table[.//th[contains(.,"MP")]]//tr[td]//td[2]//a[not(@class="new")]/@title',
) 
EveryPolitician::Wikidata.scrape_wikidata(names: { en: names })

