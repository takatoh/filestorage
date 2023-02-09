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
        if sensitive_file_exist?(path, filename)
          raise AlreadyExist.new("Already exist #{path / filename}")
        end
        path = path / filename
        super(file, path)
      rescue AlreadyExist
        retry
      end
      path.to_s
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

    def sensitive_file_exist?(path, filename)
      if @case_sensitive && path.exist?
        path.children.map{|f| f.basename.to_s.upcase }.include?(filename.upcase)
      end
    end

  end   # of class LocalRandom

end   # of module Filestorage
