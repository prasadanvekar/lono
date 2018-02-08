require_relative "../spec_helper"

describe Lono do
  describe "lono" do
    before(:each) do
      @env = "LONO_ROOT=#{ENV['LONO_ROOT']}"
    end
    after(:each) do
      FileUtils.rm_rf("spec/fixtures/my_project/params/base")
    end

    it "generate should build templates" do
      out = execute("#{@env} bin/lono generate")
      expect(out).to match /Generating both CloudFormation template and parameter/
    end

    # it "import should download template" do
    #   out = execute("#{@env} bin/lono import spec/fixtures/raw_templates/aws-waf-security-automations.template #{@args}")
    #   expect(out).to match /Imported raw CloudFormation template/
    # end
  end
end

