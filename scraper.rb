#!/bin/env ruby
# encoding: utf-8

require 'wikidata/fetcher'

names = EveryPolitician::Wikidata.wikipedia_xpath(
  url: 'https://en.wikipedia.org/wiki/List_of_members_of_the_National_Assembly_of_Cambodia,_2013%E2%80%9318',
  xpath: '//table[.//th[contains(.,"Constituency")]]//tr[td]//td[last()]//a[not(@class="new")]/@title'
)
EveryPolitician::Wikidata.scrape_wikidata(names: { en: names })

