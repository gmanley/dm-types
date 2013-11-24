require 'dm-core'
require 'bcrypt'

module DataMapper
  class Property
    class BCryptHash < String

      length 60

      def load(value)
        typecast(value) unless value.nil?
      end

      def typecast(value)
        return value if value.nil? || value.kind_of?(BCrypt::Password)
        BCrypt::Password.new(value)
      rescue BCrypt::Errors::InvalidHash
        BCrypt::Password.create(value)
      end

      def dump(value)
        hash = load(value)
        return if hash.nil?
        hash_string = hash.to_s
        hash_string.encode!('UTF-8') if hash_string.respond_to?(:encode!)
        hash_string
      end

    end # class BCryptHash
  end # class Property
end # module DataMapper
