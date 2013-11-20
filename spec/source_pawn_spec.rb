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

  describe "#declare_cvar_handle" do
    specify{expect(declare_cvar_handle "someVariable-name").to eql "new Handle:g_Cvar_SomeVariableName = INVALID_HANDLE;"}
  end
  describe "#create_cvar" do
    specify{expect(create_cvar "someVariable-name").to eql 'g_Cvar_SomeVariableName = CreateConVar("sm_some_variable_name", "1", "TODO - Add a description for this cvar");'}
  end

  describe "#declare_global_variable" do
    specify{expect(declare_global_variable "someVariable-name").to eql 'new g_SomeVariableName;'}
  end

  describe "#register_console_command" do
    specify{expect(register_console_command "someVariable-name").to eql 'RegConsoleCmd("sm_some_variable_name", Command_SomeVariableName, "TODO - Add a description for this cmd");'}
  end
  describe "#hook_event" do
    specify{expect(hook_event "someVariable-name").to eql 'HookEvent("some_variable_name", Event_SomeVariableName);'}
  end

  describe "#command_callback" do
    specify{expect(command_callback "someVariable-name").to eql <<-EOF
public Action:Command_SomeVariableName(client, args)
{
    //TODO
    return Plugin_Handled;
}
EOF
    }
  end
  describe "#event_callback" do
    specify{expect(event_callback "someVariable-name").to eql <<-EOF
public Event_SomeVariableName(Handle:event, const String:name[], bool:dontBroadcast)
{
    //TODO
    return Plugin_Continue;
}
EOF
    }
  end

end
