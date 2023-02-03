require "filestorage/version"
require "filestorage/local"
require "filestorage/local_random"

module Filestorage
  class NotExist < StandardError; end
  class AlreadyExist < StandardError; end
end
