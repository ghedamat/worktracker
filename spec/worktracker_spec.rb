require 'spec_helper.rb'
require 'timecop'

describe Worktracker do

  describe Project do
    it "should create a slug for a name" do
      Project.create(name: "My Project")
      Project.first.slug.should == "my_project"
    end

    it "should have a default project" do
      Project.default_project.name.should == "default"
    end
  end

  describe Step do
    it "should start" do
      expect do
        Step.start
      end.to change{Step.count}.by(1)
    end

    it "should not start twice" do
      expect do
        Step.start
        Step.start
      end.to change{Step.count}.by(1)
    end

    it "should start the default project if none given" do
      Step.start
      Step.last.project.should == Project.default_project
    end

    it "should not stop if not started" do
      expect do
        Step.stop
      end.to change{Step.count}.by(0)
    end

    it "should stop only if started" do
      expect do
        Step.start
        Step.stop
      end.to change{Step.count}.by(2)
    end

    it "should not stop twice" do
      expect do
        Step.start
        Step.stop
        Step.stop
      end.to change{Step.count}.by(2)
    end

    it "should return today's elements"

  end

  it "extra test" do
    Timecop.freeze
    Step.start
    Timecop.freeze(3600)
    Step.stop
  end
end
