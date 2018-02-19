class PluginTreeVersion 

  include Comparable

  def initialize version
   unless self.class.correct?(version)
    raise ArgumentError, "Malformed version number string #{version}"
   end

    # If version is an empty string convert it to 0
    version = 0 if version =~ /\A\s*\Z/

    @version = version.to_s.strip.gsub("-",".pre.")
    @segments = nil
  end

  def <=> other
   puts "This = #{self._version}, Other = #{other._version}" 

   return unless PluginTreeVersion === other
   return 0 if @version == other._version 

   lhsegments = _segments
   rhsegments = other._segments

   lhsize = lhsegments.size
   rhsize = rhsegments.size
   limit  = (lhsize > rhsize ? lhsize : rhsize) - 1

   i = 0

   while i <= limit
    lhs, rhs = lhsegments[i] || 0, rhsegments[i] || 0
    i += 1

    next    if lhs == rhs
    return -1 if String  === lhs && Numeric === rhs
    return  1 if Numeric === lhs && String  === rhs

    return lhs <=> rhs
   end

   return 0
  end

  def self.correct? version
    true
  end

  def _version 
    @version
  end

  def _segments
    # segments is lazy so it can pick up version values that come from
    # old marshaled versions, which don't go through marshal_load.
    # since this version object is cached in @@all, its @segments should be frozen

    @segments ||= @version.scan(/[0-9]+|[a-z]+/i).map do |s|
      /^\d+$/ =~ s ? s.to_i : s
    end.freeze
  end
end
