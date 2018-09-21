#!/bin/env ruby
# frozen_string_literal: true

require 'wikidata/fetcher'

names_2013 = EveryPolitician::Wikidata.wikipedia_xpath(
  url: 'https://en.wikipedia.org/wiki/List_of_members_of_the_National_Assembly_of_Cambodia,_2013%E2%80%9318',
  xpath: '//table[.//th[contains(.,"Constituency")]]//tr[td]//td[last()]//a[not(@class="new")]/@title'
)

names_2018 = EveryPolitician::Wikidata.wikipedia_xpath(
  url: 'https://en.wikipedia.org/wiki/List_of_current_members_of_the_National_Assembly_of_Cambodia',
  xpath: '//table[.//th[contains(.,"Constituency")]]//tr[td]//td[last()]//a[not(@class="new")]/@title'
)

sparq = 'SELECT DISTINCT ?item WHERE { ?item p:P39/ps:P39 wd:Q21295974 }'
ids = EveryPolitician::Wikidata.sparql(sparq)

EveryPolitician::Wikidata.scrape_wikidata(ids: ids, names: { en: names_2013 | names_2018 })
