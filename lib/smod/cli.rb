module Smod

  require 'thor'
  class CLI < Thor
    include Thor::Actions
    include SourcePawn

    desc "init PROJECT-NAME options args", "Generate a skeleton Sourcemod project"
    option :file_name, desc: "File name of the script"
    option :author, desc: "Your name", default: "Your git name"
    option :email, desc: "Your email", default: "Your git email"
    option :description, desc: "Short description for your project"
    option :version, desc: "Version to start your project at"
    option :url, desc: "Your project homepage"
    long_desc <<-LONGDESC
    `smod init` will stub out a sourcemod project for you
 
    It can optionally take a list of cvars, global variables,
    game events and console commands that will stubout for you.

    <CVAR NAME>:cvar

    <GLOBAL NAME>:global

    <EVENT NAME>:event

    <COMMAND NAME>:command
 

    > $ smod init "newPlugin" --author="John Smith" --url="johnsmith.example.com" enabled:cvar adminsonly:cvar playerenabled:global player_death:event round_end:event sm_trigger:command
 
    LONGDESC

    def init(name_arg, *args)
      name = name_arg.chomp("/")

      git_user_name = `git config user.name`.chomp
      git_user_email = `git config user.email`.chomp

      opts = {
        file_name: options[:file_name],
        author: options[:author] || git_user_name.empty? ? nil: git_user_name,
        email: options[:email] || git_user_email.empty? ? nil: git_user_email,
        description: options[:description],
        version: options[:version],
        url: options[:url]
      }

      @project = Project.new name, opts, *args
      target = File.join(Dir.pwd, name)
      template(File.join("newproject/LICENSE.txt.tt"), File.join(target, "LICENSE.txt"), @project)
      template(File.join("newproject/README.md.tt"), File.join(target, "README.md"), @project)
      template(File.join("newproject/Rakefile.tt"), File.join(target, "Rakefile"), @project)
      template(File.join("newproject/gitignore.tt"), File.join(target, ".gitignore"), @project)

      template(File.join("newproject/addons/sourcemod/scripting/_plugin.sp.tt"), File.join(target, @project.script_path), @project)
      
      if options[:translations]
        template(File.join("newproject/addons/sourcemod/translations/_plugin.phrases.txt.tt"), File.join(target, @project.translations_path), @project)
      end

      if options[:config]
        template(File.join("newproject/addons/sourcemod/config/_plugin/_plugin.cfg.tt"), File.join(target, @project.config_path), @project)
      end

      if options[:include_file]
        template(File.join("newproject/addons/sourcemod/scripting/include/_plugin.inc.tt"), File.join(target, @project.include_path), @project)
      end

      Dir.chdir(target) { `git init`; `git add .`; `git commit -m 'First'` }
    end



    def self.source_root
      File.expand_path(File.join(File.dirname(__FILE__), 'templates'))
    end

  end

end
