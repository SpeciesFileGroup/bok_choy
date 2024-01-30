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
  # @param scientific_name [String] A canonical scientific name (e.g., Achenium lusitanicum)
  # @param authors [String, nil] A string of author names without the year (e.g., Skalitzky)
  # @param year [Integer, nil] The year of publication (e.g., 1884)
  # @param json [Hash, nil] An optional JSON hash of name and reference data (overrides all other parameters)
  #
  # @param verbose [Boolean] Print headers to STDOUT
  #
  # @return [Hash] A result hash
  def self.name_refs(scientific_name: nil, authors: nil, year: nil, json: nil, verbose: false)
    endpoint = 'name_refs'
    if json.nil?
      json = {"name": {}}
      json[:name][:nameString] = scientific_name unless scientific_name.nil?
      json[:name][:author] = authors unless authors.nil?
      json[:name][:year] = year unless year.nil?
    end
    Request.new(endpoint: endpoint, json: json, verbose: verbose).perform
  end

  # Finds BHL nomenclatural event references for a name
  # @param scientific_name [String] A canonical scientific name (e.g., Achenium lusitanicum)
  # @param authors [String, nil] A string of author names without the year (e.g., Skalitzky)
  # @param year [Integer, nil] The year of publication (e.g., 1884)
  # @param json [Hash, nil] An optional JSON hash of name and reference data (overrides all other parameters)
  #
  # @param verbose [Boolean] Print headers to STDOUT
  #
  # @return [Hash] A result hash
  def self.nomen_refs(scientific_name: nil, authors: nil, year: nil, json: nil, verbose: false)
    endpoint = 'nomen_refs'
    if json.nil?
      json = {"name": {}}
      json[:name][:nameString] = scientific_name unless scientific_name.nil?
      json[:name][:author] = authors unless authors.nil?
      json[:name][:year] = year unless year.nil?
    end
    Request.new(endpoint: endpoint, json: json, verbose: verbose).perform
  end

  # Get BHL reference metadata by page ID
  #
  # @param id [String] A page ID from BHL
  #
  # @param verbose [Boolean] Print headers to STDOUT
  #
  # @return [Hash, String, Boolean] A JSON-LD hash or CSV
  def self.page(id, verbose: false)
    endpoint = "references/#{id}"
    Request.new(endpoint: endpoint, verbose: verbose).perform
  end

  # Finds BHL references for a taxon (includes references of synonyms)
  # @param scientific_name [String] A canonical scientific name (e.g., Achenium lusitanicum)
  # @param authors [String, nil] A string of author names without the year (e.g., Skalitzky)
  # @param year [Integer, nil] The year of publication (e.g., 1884)
  # @param json [Hash, nil] An optional JSON hash of name and reference data (overrides all other parameters)
  #
  # @param verbose [Boolean] Print headers to STDOUT
  #
  # @return [Hash] A result hash
  def self.taxon_refs(scientific_name: nil, authors: nil, year: nil, json: nil, verbose: false)
    endpoint = 'taxon_refs'
    if json.nil?
      json = {"name": {}}
      json[:name][:nameString] = scientific_name unless scientific_name.nil?
      json[:name][:author] = authors unless authors.nil?
      json[:name][:year] = year unless year.nil?
    end
    Request.new(endpoint: endpoint, json: json, verbose: verbose).perform
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
