require 'spec_helper'
include SourcePawn

describe SourcePawn do
  describe "#to_snake_case" do
    specify{expect(to_snake_case "dotted-line").to eql "dotted_line"}
    specify{expect(to_snake_case "CamelCase").to eql "camel_case"}
    specify{expect(to_snake_case "with spaces").to eql "with_spaces"}
    specify{expect(to_snake_case "with_underscore").to eql "with_underscore"}
    specify{expect(to_snake_case "single").to eql "single"}
  end
  describe "#to_camel_case" do
    specify{expect(to_camel_case "dotted-line").to eql "DottedLine"}
    specify{expect(to_camel_case "dotted-line", :lower).to eql "dottedLine"}
    specify{expect(to_camel_case "CamelCase").to eql "CamelCase"}
    specify{expect(to_camel_case "CamelCase", :lower).to eql "camelCase"}
    specify{expect(to_camel_case "with spaces").to eql "WithSpaces"}
    specify{expect(to_camel_case "with spaces", :lower).to eql "withSpaces"}
    specify{expect(to_camel_case "with_underscore").to eql "WithUnderscore"}
    specify{expect(to_camel_case "with_underscore", :lower).to eql "withUnderscore"}
    specify{expect(to_camel_case "single").to eql "Single"}
    specify{expect(to_camel_case "single", :lower).to eql "single"}
  end
end
