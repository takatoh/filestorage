# encoding: utf-8

require "pathname"
require "fileutils"
require "find"
require "securerandom"
require "filesotrage"


module Filestorage

  class LocalRandom < Local

    DEFAULT_LETTERS = "abcdefghijklmnopqrstuvwxyz0123456789"
    DEFAULT_LENGTH = 8

    def initialize(base_dir, length = DEFAULT_LENGTH)
      @base_dir = Pathname.new(base_dir)
      @filename_length = length
      @letter_pool = DEFAULT_LETTERS
    end

    def store(file)
      begin
        filename = gen_random + File.extname(file)
        path = [filename[0, 2].upcase, filename[2, 2].upcase, filename].join("/")
        super(file, path)
      rescue AlreadyExist
        retry
      end
      path
    end

    private

    def gen_random
      s = []
      @filename_length.times do
        c = up(@letter_poool[SecureRandom.random_number(@filename_length)])
        s << c
      end
      s.join
    end

    def up(c)
      [true, false].sample ? c.upcase : c
    end

  end   # of class LocalRandom

end   # of module Filestorage
