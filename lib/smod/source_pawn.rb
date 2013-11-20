module Smod
  #Logic for building sourcepawn code elements
  module SourcePawn
    def to_snake_case str
      str.gsub(/::/, '/').
        gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
        gsub(/([a-z\d])([A-Z])/,'\1_\2').
        tr("-", "_").
        tr(" ", "_").
        downcase
    end

    def to_camel_case str, first_letter = :upper
      count = 0
      str.split(/[_\-\s]/).map do |e|
        count += 1
        if count == 1 && first_letter == :lower
          e.slice(0,1).downcase + e.slice(1..-1)
        else
          e.slice(0,1).capitalize + e.slice(1..-1)
        end
      end.join
    end
  end
end
