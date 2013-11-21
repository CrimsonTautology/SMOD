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

    def readme_cvar str
      %Q{- `sm_#{to_snake_case str}` TODO - Add description}
    end
    def readme_command str
      %Q{- `!#{to_snake_case str}` TODO - Add description}
    end
    def declare_cvar_handle str
      %Q{new Handle:g_Cvar_#{to_camel_case str} = INVALID_HANDLE;}
    end
    def create_cvar str
      %Q{g_Cvar_#{to_camel_case str} = CreateConVar("sm_#{to_snake_case str}", "1", "TODO - Add a description for this cvar");}
    end

    def declare_global_variable str
      %Q{new g_#{to_camel_case str};}
    end

    def register_console_command str
      %Q{RegConsoleCmd("sm_#{to_snake_case str}", Command_#{to_camel_case str}, "TODO - Add a description for this cmd");}
    end
    def hook_event str
      %Q{HookEvent("#{to_snake_case str}", Event_#{to_camel_case str});}
    end

    def command_callback str
      <<-EOF
public Action:Command_#{to_camel_case str}(client, args)
{
    //TODO
    return Plugin_Handled;
}
EOF
    end

    def event_callback str
      <<-EOF
public Event_#{to_camel_case str}(Handle:event, const String:name[], bool:dontBroadcast)
{
    //TODO
    return Plugin_Continue;
}
EOF

    end
  end
end
