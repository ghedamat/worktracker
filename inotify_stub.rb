#!/usr/bin/env ruby

require 'rb-inotify'

notifier = INotify::Notifier.new

path = File.expand_path(File.dirname(__FILE__))
puts path
notifier.watch(path,:modify) do |event|
  puts "#{event.name} #{event.notifier} #{event.related} happened!"
end

notifier.run
