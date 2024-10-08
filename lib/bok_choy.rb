# frozen_string_literal: true
require "erb"
require_relative "bok_choy/error"
require_relative "bok_choy/version"
require_relative "bok_choy/request"
require "bok_choy/helpers/configuration"

# The BokChoy module provides a Ruby interface to the BHL Names API
module BokChoy
  extend Configuration

  define_setting :base_url, "https://bhlnames.globalnames.org/api/v1/"
  define_setting :mailto, ENV["BOK_CHOY_API_EMAIL"]

  # Finds BHL references for a name
  # @param name [String] A canonical scientific name (e.g., Pardosa moesta)
  # @param author [String, nil] An author string (e.g., Banks)
  # @param year [String, nil] A year string (e.g., 1892)
  # @param reference [String, nil] A reference string (e.g., Docums Mycol. 34(nos 135-136))
  # @param nomen_event [Boolean, nil] If true, tries to find nomenclatural event reference (default: true)
  # @param json [Hash, nil] An optional JSON hash of name and reference data (overrides all other parameters)
  # @param verbose [Boolean] Print headers to STDOUT
  #
  # @return [Hash] A result hash
  def self.name_refs(name: nil, author: nil, year: nil, reference: nil, nomen_event: true, json: nil, verbose: false)
    raise "Name or json required" if name.nil? && json.nil?

    if json.nil?
      json = {'name': {}, 'reference': {}, 'params': {}}
      json[:name][:nameString] = name
      json[:name][:author] = author unless author.nil?
      json[:name][:year] = year unless year.nil?
      json[:reference][:refString] = reference unless reference.nil?
      json[:params][:nomenEvent] = nomen_event
    end
    endpoint = "name_refs"
    Request.new(endpoint: endpoint, json: json, verbose: verbose).perform
  end

  # Finds a nomenclatural event in BHL by an external ID from a data source
  # 
  # @param id [String] An external ID from a data source
  # @param verbose [Boolean] Print headers to STDOUT
  # 
  # @return [Hash] A result hash
  def self.cached_refs(id, verbose: false)
    raise "ID required" if id.nil?

    endpoint = "cached_refs/#{id}"
    Request.new(endpoint: endpoint, verbose: verbose).perform
  end

  # Get metadata and taxonomic statistics for a BHL item
  # 
  # @param id [String] A BHL item ID
  # @param verbose [Boolean] Print headers to STDOUT
  # 
  # @return [Hash] A result hash
  def self.items(id, verbose: false)
    raise "ID required" if id.nil?

    endpoint = "items/#{id}"
    Request.new(endpoint: endpoint, verbose: verbose).perform
  end

  # Get BHL reference metadata by page ID
  #
  # @param id [String] A page ID from BHL
  # @param verbose [Boolean] Print headers to STDOUT
  #
  # @return [Hash, String, Boolean] A JSON-LD hash or CSV
  def self.page(id, verbose: false)
    raise "ID required" if id.nil?

    endpoint = "references/#{id}"
    Request.new(endpoint: endpoint, verbose: verbose).perform
  end

  # Finds BHL items in which a given higher taxon is prevalent
  # 
  # @param taxon_name [String] A taxonomic name (e.g., Lepidoptera)
  # @param verbose [Boolean] Print headers to STDOUT
  #
  # @return [Hash] A result hash
  def self.taxon_items(taxon_name: nil, verbose: false)
    raise "Taxon name required" if taxon_name.nil?

    taxon_url = ERB::Util.url_encode(taxon_name)
    endpoint = "taxon_items/#{taxon_url}"
    Request.new(endpoint: endpoint, verbose: verbose).perform
  end

  # Gets BHL reference metadata by page ID
  # 
  # @param id [String] A page ID from BHL
  # @param verbose [Boolean] Print headers to STDOUT
  # 
  # @return [Hash] A result hash
  def self.references(id, verbose: false)
    raise "ID required" if id.nil?

    endpoint = "references/#{id}"
    Request.new(endpoint: endpoint, verbose: verbose).perform
  end

  # Check the API status
  #
  # @param verbose [Boolean] Print headers to STDOUT
  #
  # @return [String] A pong string
  def self.ping(verbose: false)
    endpoint = "ping"
    Request.new(
      endpoint: endpoint,
      verbose: verbose
    ).perform
  end

  # Check the API version
  #
  # @param verbose [Boolean] Print headers to STDOUT
  #
  # @return [Hash] A version hash
  def self.version(verbose: false)
    endpoint = "version"
    Request.new(
      endpoint: endpoint,
      verbose: verbose
    ).perform
  end

end
