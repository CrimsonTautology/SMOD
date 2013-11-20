require 'spec_helper'

describe Project do
  describe "#new" do
    subject {@project}
    context "default" do
      before do
        @project = Project.new "Example Project"
      end

      its(:name) {should eql "Example Project"}
      its(:file_name) {should eql "example_project"}
      its(:author) {should eql DEFAULT_AUTHOR}
      its(:description) {should eql DEFAULT_DESCRIPTION}
      its(:version) {should eq DEFAULT_VERSION}
      its(:url) {should eql DEFAULT_URL}

      its(:cvar_list){should be_empty}
      its(:global_list){should be_empty}
      its(:event_list){should be_empty}
      its(:command_list){should be_empty}
    end

    context "with options" do
      before do
        @project = Project.new "Example Project", {
          file_name: "new_name",
          author: "Some Guy",
          description: "It does stuff",
          version: "3.4.5",
          url: "http://example.com"
        }
      end

      its(:name) {should eql "Example Project"}
      its(:file_name) {should eql "new_name"}
      its(:author) {should eql "Some Guy"}
      its(:description) {should eql "It does stuff"}
      its(:version) {should eq "3.4.5"}
      its(:url) {should eql  "http://example.com"}
    end

    context "with args" do
      before do
        @project = Project.new "Example Project", {}, "variableName:cvar", "global-var:global", "round_start:event", "sm_stop:command", "sm_trigger:command", "variableName2:cvar", "stuff:fake"
      end

      its(:cvar_list){should match_array(["variableName", "variableName2"])}
      its(:global_list){should match_array(["global-var"])}
      its(:event_list){should match_array(["round_start"])}
      its(:command_list){should match_array(["sm_trigger", "sm_stop"])}

    end
  end
end
