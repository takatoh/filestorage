# encoding: utf-8

require "pathname"
require "fileutils"
require "find"
require "securerandom"
require "filesotrage"


module Filestorage

  class LocalRandom < Local

    DEFAULT_LETTERS = "abcdefghijklmnopqrstuvwxyz0123456789"

    def initialize(base_dir, pool = nil, length = nil)
      @base_dir = Pathname.new(base_dir)
      @letter_pool = pool || DEFAULT_LETTERS
      @filename_length = length || 8
    end

    def store(file, ext)
      filename = gen_random + ext
      path = [filename[0, 2].upcase, filename[2, 2].upcase, filename].join("/")
      super(file, path)
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

#      def sweep(path)
#        paths(path).reverse.each do |p|
#          FileUtils.rmdir(p) if p.children.empty?
#        end
#      end

#      def paths(path)
#        p = []
#        until path.to_s == @base_dir.to_s
#          p << path
#          path = path.parent
#        end
#        p.reverse
#      end

  end   # of class LocalRandom

end   # of module Filestorage
