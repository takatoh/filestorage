# encoding: utf-8

require 'pathname'
require 'fileutils'
require 'find'


module Filestorage

  class Local
  
    def initialize(base_dir)
      @base_dir = Pathname.new(base_dir)
    end

    def store(path, file)
      fullpath = @base_dir + path
      raise AlreadyExist.new("Already exist #{path}") if File.exist?(fullpath)
      FileUtils.mkdir_p(fullpath.parent)
      if file.instance_of?(Pathname)
        FileUtils.cp(file, fullpath)
      elsif file.instance_of?(File)
        File.open(fullpath, "wb") do |f|
          f.write(file.read)
        end
      else
        File.open(fullpath, "wb") do |f|
          f.write(file)
        end
      end
      path
    end

    def get(path)
      fullpath = @base_dir + path
      raise NotExist.new("Not exist #{path}") unless File.exist?(fullpath)
      File.open(fullpath, "rb")
    end

    def delete(path, delete_dir: false)
      fullpath = @base_dir + path
      raise NotExist.new("Not exist #{path}") unless File.exist?(fullpath)
      FileUtils.rm(fullpath)
      sweep(fullpath.parent) if delete_dir
      path
    end

    def exist?(path)
      fullpath = @base_dir + path
      File.exist?(fullpath)
    end

    def files
      files = []
      Find.find(@base_dir.to_s) do |f|
        f = Pathname.new(f)
        files << f.relative_path_from(@base_dir).to_s if f.file?
      end
      files
    end

    private

      def sweep(path)
        paths(path).reverse.each do |p|
          FileUtils.rmdir(p) if p.children.empty?
        end
      end

      def paths(path)
        p = []
        until path.to_s == @base_dir.to_s
          p << path
          path = path.parent
        end
        p.reverse
      end

  end   # of class Local

end   # of module Filestorage
