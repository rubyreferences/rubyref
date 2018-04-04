#!/usr/bin/env ruby

require 'fileutils'
require 'pp'
require 'dry/inflector'
require 'yaml'
require 'kramdown'
require 'hm'
require 'ripper'
require 'pathname'
require 'did_you'

require_relative 'base'

$:.unshift 'lib'
require 'render/book'

# Otherwise Ripper would spit some warnings on sterr
def Warning.warn(*); end

root = File.expand_path('..', __dir__)
config = File.expand_path('../config/structure.yml', __dir__)
out = File.expand_path('../..', __dir__)

LEAVE = %r{^#{Regexp.escape(out)}/(_|Gemfile|css|js|images)}

p "Removing: ", Dir[File.join(out, '*')].grep_v(LEAVE) #.each(&FileUtils.method(:rm_rf))

Book.load(root, config).write(out)