# frozen_string_literal: true

require_relative 'mongo_challenge'

def main(args)
  throw 'Missing input json file path' if args.empty?
  throw 'Missing output json file path' if args.length == 1

  input_path = "#{File.dirname(__FILE__)}/#{args[0]}"
  output_path = "#{File.dirname(__FILE__)}/#{args[1]}"

  json = load_json_file(input_path)
  flattened_json = flatten(json)
  save_json_file(output_path, flattened_json)
end

main(ARGV)
