ENV['TEST'] = '1'
# Ensures aws api never called. Fixture home folder does not contain ~/.aws/credentails
ENV['HOME'] = "spec/fixtures/home"
# We'll always re-generate a new lono project in tmp. It can be:
#
#   1. generated from `lono new`
#   2. copied from spec/fixtures/lono_project
ENV['LONO_ROOT'] = "tmp/lono_project" # this gets kept

require "pp"
require "byebug"

# require "bundler"
# Bundler.require(:development)

root = File.expand_path("../", File.dirname(__FILE__))
require "#{root}/lib/lono"

module Helper
  def execute(cmd)
    puts "Running: #{cmd}" if show_command?
    out = `#{cmd}`
    puts out if show_command?
    out
  end

  # Added SHOW_COMMAND because DEBUG is also used by other libraries like
  # bundler and it shows its internal debugging logging also.
  def show_command?
    ENV['DEBUG'] || ENV['SHOW_COMMAND']
  end

  def ensure_tmp_exists
    FileUtils.mkdir_p("tmp")
  end
end

RSpec.configure do |c|
  c.include Helper
  c.before(:all) do
    ensure_tmp_exists
  end
end
