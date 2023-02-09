# encoding: utf-8

require "pathname"
require "fileutils"
require "find"
require "securerandom"


module Filestorage

  class LocalRandom < Local

    DEFAULT_LETTERS = "abcdefghijklmnopqrstuvwxyz0123456789"
    DEFAULT_LENGTH = 8

    def initialize(base_dir, length: DEFAULT_LENGTH, sensitive: false)
      @base_dir = Pathname.new(base_dir)
      @filename_length = length
      @letter_pool = DEFAULT_LETTERS
      @pool_size = @letter_pool.size
      @case_sensitive = sensitive
    end

    def store(file)
      begin
        filename = gen_random + File.extname(file)
        d1 = filename[0, 2].upcase
        d2 = filename[2, 2].upcase
        path = Pathname.new(d1) / d2
        if @case_sensitive && path.exist?
          if path.children.map{|f| f.basename.to_s.upcase }.include?(filename.upcase)
            raise AlreadyExist.new("Already exist #{path / filename}")
          end
        end
        path = path / filename
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
        c = up(@letter_pool[SecureRandom.random_number(@pool_size)])
        s << c
      end
      s.join
    end

    def up(c)
      [true, false].sample ? c.upcase : c
    end

  end   # of class LocalRandom

end   # of module Filestorage
