require 'yaml'

module Lono
  class Setting
    def initialize(check_lono_project=true)
      @check_lono_project = check_lono_project
    end

    # data contains the settings.yml config.  The order or precedence for settings
    # is the project lono/settings.yml and then the ~/.lono/settings.yml.
    @@data = nil
    def data
      return @@data if @@data

      if @check_lono_project && !File.exist?(project_settings_path)
        puts "ERROR: No settings file at #{project_settings_path}.  Are you sure you are in a project with lono setup?".colorize(:red)
        exit 1
      end

      # project based settings files
      project = load_file(project_settings_path)

      user_file = "#{ENV['HOME']}/.lono/settings.yml"
      user = load_file(user_file)

      default_file = File.expand_path("../default/settings.yml", __FILE__)
      default = load_file(default_file)

      all_envs = default.deep_merge(user.deep_merge(project))
      all_envs = merge_base(all_envs)
      @@data = all_envs[Lono.env] || all_envs["base"] || {}
    end

    # Special helper method to support multiple formats for s3_folder setting.
    # Format 1: Simple String
    #
    #   development:
    #     s3_folder: mybucket/path/to/folder
    #
    # Format 2: Hash
    #
    #   development:
    #     s3_folder:
    #       default: mybucket/path/to/folder
    #       dev_profile1: mybucket/path/to/folder
    #       dev_profile1: another-bucket/storage/path
    #
    def s3_folder
      s3_folder = data['s3_folder']
      return s3_folder if s3_folder.nil? or s3_folder.is_a?(String)

      # If reach here then the s3_folder is a Hash
      s3_folder[ENV['AWS_PROFILE']] || s3_folder["default"]
    end

  private
    def load_file(path)
      return Hash.new({}) unless File.exist?(path)

      content = RenderMePretty.result(path)
      data = YAML.load(content) || {}
      # If key is is accidentally set to nil it screws up the merge_base later.
      # So ensure that all keys with nil value are set to {}
      data.each do |lono_env, _setting|
        data[lono_env] ||= {}
      end
      data
    end

    # automatically add base settings to the rest of the environments
    def merge_base(all_envs)
      base = all_envs["base"] || {}
      all_envs.each do |lono_env, env_settings|
        all_envs[lono_env] = base.merge(env_settings) unless lono_env == "base"
      end
      all_envs
    end

    def project_settings_path
      "#{Lono.root}/config/settings.yml"
    end
  end
end
