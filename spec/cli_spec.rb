require 'spec_helper'
require 'tmpdir'

describe CLI do
  before :all do
    @original = Dir.getwd
    @root = Dir.mktmpdir
    Dir.chdir @root
  end
  before do
    @cli = CLI.new
  end

  describe ".init" do
    specify{expect(@cli.init("File name", "enabled:cvar", "value:global", "game_end:event", "game_start:event", "crap", "crap:2", "startup:command", "stopdown:command", "turnoff:command", "round_start:event")).to_not raise_error(NameError)}
  end

  after :all do
    Dir.chdir @original
  end
end
