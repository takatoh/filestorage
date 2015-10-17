require "filestorage/version"
require "filestorage/local"

module Filestorage
  class NotExist < StandardError; end
  class AlreadyExist < StandardError; end
end
