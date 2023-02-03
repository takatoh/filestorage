# Filestorage

A simple file storage.

## Installation

Add this line to your application's Gemfile:

    gem "filestorage"

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install filestorage

## Store to local file system

Create a instance.

```ruby
require "filestorage"
storage = Filesotrage::Local.new(base_dir)
```

Store a file to path.

```ruby
storage.store("foo/bar/baz.txt", file)
```

And get the file. `get` method returns instance of File class.

```ruby
file = storage.get("foo/bar/baz.txt")
content = file.read
```

## Store to local with random file name

Use `Fielstorage:LocalRandom` class.

Create a instance.

```ruby
require "filestorage"
storage = Filesotrage::LocalRandom.new(base_dir, letters, length)
```

`letters` is candidate characters to build a filename, default to lower latin alphabets and digits.
`length` is for filename, default to `8`.

Store a file.

```ruby
storage.store(file)
```

Returns path to stored file, e.g. "5Q/CY/5QCyP0gT.txt"

And get the file. `get` method returns instance of File class.

```ruby
file = storage.get("5Q/CY/5QCyP0gT.txt")
content = file.read
```

## License

MIT license
