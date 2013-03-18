require "worktracker/version"

require 'sequel'
require 'timecop'
require 'awesome_print'
require 'time'
require 'pry'

# TODO move this stuff
DB = Sequel.sqlite

DB.create_table :projects do
  primary_key :id
  String :name
  String :slug
  String :path

end

DB.create_table :steps do
  primary_key :id
  foreign_key :project_id, :projects
  String :start_time
  String :action
end

module Worktracker

  class Project < Sequel::Model
    one_to_many :step

    def before_save
      super
      self.slug = name.downcase.gsub(/\W/,'_')
    end

    def self.default_project
      Project.find(name: "default") || Project.create(name: "default")
    end
  end

  class Step < Sequel::Model
    many_to_one :project

    def self.start(project=nil)
      unless started?
        project ||= Project.default_project
        Step.create(start_time: Time.now, action: "start", project: project)
      end
    end

    def self.last_by_time
      Step.order(:start_time).all.last
    end

    def self.started?
      if Step.last_by_time
        Step.last_by_time.action == "start"
      end
    end

    def self.stop(project=nil)
      if started?
        project ||= Project.default_project
        Step.create(start_time: Time.now, action: "stop", project: project)
      end
    end

    def self.with_project(_project=nil)
      if _project
        Step.where(project: _project).all
      else
        Step.all
      end
    end

    def self.today
      Step.where(start_time: (Time.now)..(Date.today.to_time)).all
    end

    def time
      Time.parse start_time
    end

  end

  class Analyzer

    attr_reader :data

    def initialize(data)
      @data = data
      sanitize
    end

    def partition
      data.each_slice(2)
    end

    def sum
      partition.inject(0)do |acc,step|
        acc += step[1].time - step[0].time
      end
    end
  end

end

