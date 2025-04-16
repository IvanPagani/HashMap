# frozen_string_literal: true

class HashMap
  attr_reader :load_factor, :capacity
  # The attr_reader bellow is just for TESTING
  # It should be DELETED
  attr_reader :buckets

  def initialize(load_factor = 0.75, capacity = 16)
    @load_factor = load_factor
    @capacity = capacity
    @size = 0
    @buckets = Array.new(@capacity) { [] }
  end

  def set(key, value)
    bucket = @buckets[hash(key).abs % @capacity]
    has_key_value = bucket.find { |k, _| k == key }

    if has_key_value
      has_key_value[1] = value
    else
      bucket << [key, value]
      @size += 1
    end

    resize if @size > @capacity * @load_factor
  end

  def remove(key)
    bucket = @buckets[hash(key).abs % @capacity]

    bucket.each_with_index do |pair, index|
      next unless pair[0] == key

      bucket.delete_at(index)
      @size -= 1
      resize if @size < @capacity / 4 && @capacity > 8

      return pair[1]
    end

    nil
  end

  def get(key)
    bucket = @buckets[hash(key).abs % @capacity]
    has_key_value = bucket.find { |k, _| k == key }
    has_key_value ? has_key_value[1] : nil
  end

  def has?(key)
    bucket = @buckets[hash(key).abs % @capacity]
    has_key_value = bucket.find { |k, _| k == key }
    has_key_value ? true : false
  end

  def length
    @size
  end

  def clear
    @size = 0
    @buckets = Array.new(@capacity) { [] }
  end

  def keys
    @buckets.flat_map { |bucket| bucket.map { |k, _| k } }
  end

  def values
    @buckets.flat_map { |bucket| bucket.map { |_, v| v } }
  end

  def entries
    @buckets.flat_map { |bucket| bucket.map { |k, v| [k, v] } }
  end

  private

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }
    hash_code
  end

  def resize
    old_buckets = @buckets

    if @size > @capacity * @load_factor
      @capacity *= 2
    elsif @size < @capacity / 4 && @capacity > 8
      @capacity /= 2
    end

    @size = 0
    @buckets = Array.new(@capacity) { [] }

    old_buckets.each do |bucket|
      bucket.each { |key, value| set(key, value) }
    end
  end
end
