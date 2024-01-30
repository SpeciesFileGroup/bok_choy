# BokChoy

BokChoy is a Ruby wrapper on the [BHLNames](https://github.com/gnames/bhlnames) API. Code follow the spirit/approach of the Gem [serrano](https://github.com/sckott/serrano), and indeed much of the wrapping utility is copied 1:1 from that repo, thanks [@sckott](https://github.com/sckott).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bok_choy'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install bok_choy

## Usage


---
### Ping
Test the status of the API service:
```ruby
BokChoy.ping  #  => String
```

---
### Name references
Find BHL references for a scientific name
```ruby
BokChoy.name_refs(scientific_name: 'Achenium lusitanicum', authors: 'Skalitzky', year: 1884) #  => Hash
```
Find a BHL reference for a scientific name with a [JSON request](https://bhlnames.globalnames.org/apidoc/index.html#/default/post-name-refs):
```ruby
BokChoy.name_refs(json: BokChoy.name_refs(json: {"id": "11111", "name": {"authors": "Skalitzky", "nameString": "Achenium lusitanicum", "year": 1884}, "reference": {"yearStart": 1883, "yearEnd": 1885}})) #  => Hash
```

---
### Nomenclatural references
Find BHL nomenclatural event references for a scientific name
```ruby
BokChoy.nomen_refs(scientific_name: 'Achenium lusitanicum', authors: 'Skalitzky', year: 1884) #  => Hash
```
Find BHL nomenclatural event references for a scientific name with a [JSON request](https://bhlnames.globalnames.org/apidoc/index.html#/default/post-nomen-refs):
```ruby
BokChoy.nomen_refs(json: BokChoy.name_refs(json: {"id": "11111", "name": {"authors": "Skalitzky", "nameString": "Achenium lusitanicum", "year": 1884}, "reference": {"yearStart": 1883, "yearEnd": 1885}})) #  => Hash
```

---
### Taxon references
Find BHL references for a taxon (includes references to synonyms of the taxon in BHL)
```ruby
BokChoy.taxon_refs(scientific_name: 'Achenium lusitanicum', authors: 'Skalitzky', year: 1884) #  => Hash
```
Find BHL references for a taxon with a [JSON request](https://bhlnames.globalnames.org/apidoc/index.html#/default/post-taxon-refs):
```ruby
BokChoy.taxon_refs(json: BokChoy.name_refs(json: {"id": "11111", "name": {"authors": "Skalitzky", "nameString": "Achenium lusitanicum", "year": 1884}, "reference": {"yearStart": 1883, "yearEnd": 1885}})) #  => Hash
```

---
### Version
Get the version of the BHLnames API service:
```ruby
BokChoy.version  #  => Hash
```

---

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/SpeciesFileGroup/bok_choy. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/SpeciesFileGroup/bok_choy/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [NCSA/Illinois](https://github.com/SpeciesFileGroup/bok_choy/blob/main/LICENSE.txt) license. You can learn more about the NCSA license on [Wikipedia](https://en.wikipedia.org/wiki/University_of_Illinois/NCSA_Open_Source_License) and compare it with other open source licenses at the [Open Source Initiative](https://opensource.org/license/uoi-ncsa-php/).

## Code of Conduct

Everyone interacting in the BokChoy project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/SpeciesFileGroup/bok_choy/blob/main/CODE_OF_CONDUCT.md).
