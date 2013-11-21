module Smod
  include SourcePawn

  DEFAULT_VERSION = 0.1
  DEFAULT_AUTHOR = "TODO - Add your name/handle"
  DEFAULT_DESCRIPTION = "TODO - Add your project's description"
  DEFAULT_URL = "TODO - Add your project's homepage or online repository"

  CVAR = "cvar"
  GLOBAL = "global"
  COMMAND = "command"
  EVENT = "event"

  #Logic for holding data pertaining to the project and it's members
  class Project
    attr_accessor :name,
      :file_name,
      :author,
      :description,
      :version,
      :url

    attr_reader :cvar_list,
      :global_list,
      :event_list,
      :command_list

    def initialize name, opts={}, *args
      @name = name

      @file_name   = opts[:file_name]   || to_snake_case(name)
      @author      = opts[:author]      || DEFAULT_AUTHOR
      @description = opts[:description] || DEFAULT_DESCRIPTION
      @version     = opts[:version]     || DEFAULT_VERSION
      @url         = opts[:url]         || DEFAULT_URL

      @cvar_list = []
      @global_list = []
      @event_list = []
      @command_list = []

      args.map{|a| a.split(":")}.each do |arg|
        next if arg[1].nil?
        case arg[1].downcase
        when CVAR
          add_cvar arg[0]
        when GLOBAL
          add_global arg[0]
        when COMMAND
          add_command arg[0]
        when EVENT
          add_event arg[0]
        end
      end

    end

    def add_cvar cvar
      @cvar_list << cvar
    end

    def add_global global
      @global_list << global
    end

    def add_command command
      @command_list << command
    end

    def add_event event
      @event_list << event
    end

    
    def script_path
      "addons/sourcemod/scripting/#{@file_name}.sp"
    end
    def translations_path
      "addons/sourcemod/translations/#{@file_name}.phrases.txt"
    end
    def config_path
      "addons/sourcemod/config/#{@file_name}/#{@file_name}.cfg"
    end
    def include_path
      "addons/sourcemod/scripting/include/#{@file_name}.inc"
    end
  end
end
