require 'spec_helper'

describe CLI do
  before do
    @cli = CLI.new
  end

  describe ".init" do
    specify{expect(@cli.init("File name")).to be_nil}
  end
end
