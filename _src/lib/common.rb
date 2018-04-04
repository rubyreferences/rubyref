require 'fileutils'
require 'pp'
require 'yaml'

BOOK_RUBY_VERSION = File.read(File.expand_path('../config/ruby_version.txt', __dir__)).chomp
$LOAD_PATH.unshift __dir__
