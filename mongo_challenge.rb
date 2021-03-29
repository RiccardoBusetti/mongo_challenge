# frozen_string_literal: true

require 'json'

def flatten(current_hash, previous_key = nil)
  flat_hash = {}

  current_hash.each do |key, value|
    # We need to compute the value of the key, based on the depth of our
    # current hash.
    current_key = previous_key.nil? ? key : "#{previous_key}.#{key}"

    # If we find an hash, it means we need to flatten it and merge that has
    # with the current one.
    # Otherwise we simply add a new value to the flat hash and return it.
    if value.is_a?(Hash)
      flat_hash = flat_hash.merge(flatten(value, current_key))
    else
      flat_hash[current_key] = value
    end
  end

  flat_hash
end

def flatten_string(json)
  return '' if json.empty?

  flatten(JSON.parse(json)).to_json
end

def load_json_file(file_path)
  file = File.read(file_path)
  JSON.parse(file)
end

def save_json_file(file_path, json)
  File.write(file_path, JSON.pretty_generate(json))
end
