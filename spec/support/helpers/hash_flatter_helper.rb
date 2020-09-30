module Helpers
  module HashFlatterHelper
    # Transforms hash and arrays in deep hash with flatten keys
    # Ex:
    # input:  {a: {c: :c}, b: [{d: :d}, {e: :e}]}
    # output: {'a.c': :c, 'b.0.d': :d, 'b.1.e': :e}
    def hash_deep_flatten(hash)
      flatten_hash_keys(deep_transform_to_hash(hash))
    end

    private

    def deep_transform_to_hash(obj)
      if obj.is_a? Hash
        obj.each do |k, v|
          obj[k] = deep_transform_to_hash(v)
        end
      elsif obj.is_a? Array
        obj = obj.each_with_index.map { |v, k| [k.to_s, v] }.to_h
        obj.each do |k, v|
          obj[k] = deep_transform_to_hash(v)
        end
      else
        obj
      end
    end

    def flatten_hash_keys(obj)
      obj.each_with_object({}) do |(key, value), memo|
        next flatten_hash_keys(value).each do |k, v|
          memo["#{key}.#{k}"] = v
        end if value.is_a? Hash
        memo[key] = value.to_s
      end
    end
  end
end
