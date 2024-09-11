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

### [Name references](https://bhlnames.globalnames.org/apidoc/index.html#/default/post-name-refs)
Although BHLnames offers a GET endpoint, the API wrapper always encodes the input parameters into JSON and uses the POST endpoint. 
For more control of the input parameters, you can omit all other parameters and directly post JSON. See the [API docs]((https://bhlnames.globalnames.org/apidoc/index.html#/default/post-name-refs)) for the full list of possible inputs in the JSON.

Find BHL reference matches for a scientific name
```ruby
BokChoy.name_refs(name: 'Pardosa moesta') #  => Hash
```

Find BHL reference matches with a scientific name, author and year:
```ruby
BokChoy.name_refs(name: 'Pardosa moesta', author: 'Banks', year: 1892, reference: 'Bulletin of the American Museum of Natural History v.29 (1911)', nomen_event: false) #  => Hash
```

Find BHL reference matches for a scientific name with a reference string:
```ruby
BokChoy.name_refs(name: 'Pardosa moesta', reference: 'Bulletin of the American Museum of Natural History v.29 (1911)') #  => Hash
```

Find BHL reference matches for a nomenclatural event:
```ruby
BokChoy.name_refs(name: 'Pardosa moesta', nomen_event: true) #  => Hash
```

Find BHL reference matches with json input:
```ruby
BokChoy.name_refs(json: {"name": {"nameString": "Pardosa moesta", "author": "Banks", "year": 1892}, "reference": {}, "params": {"nomenEvent": true}}) #  => Hash
```

---
### [Item metadata](https://bhlnames.globalnames.org/apidoc/index.html#/default/get-item)
Get BHL item metadata by item ID:
```ruby
BokChoy.items(73397) #  => Hash
```

---
### [Page reference metadata](https://bhlnames.globalnames.org/apidoc/index.html#/default/get-refs)
Get BHL reference metadata by a page ID:
```ruby
BokChoy.references(6589171) #  => Hash
```

---
### [External identifiers](https://bhlnames.globalnames.org/apidoc/index.html#/default/get-cached-refs)
Get a nomenclatural event in BHL by an external identifier:
```ruby
BokChoy.cached_refs('6C8Q2') #  => Hash
```

---
### [Ping](https://bhlnames.globalnames.org/apidoc/index.html#/default/get-ping)
Test the status of the API service:
```ruby
BokChoy.ping  #  => String
```

---
### [Version](https://bhlnames.globalnames.org/apidoc/index.html#/default/get-version)
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
