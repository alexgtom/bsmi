#!/usr/bin/env ruby

require 'pathname'

ROOT_DIR = Pathname.new(__FILE__).realpath.dirname
PROG_NAME = "glpk-4.44"
INSTALL_DIR = ROOT_DIR.join("lib/glpk")


TARBALL_NAME = "#{PROG_NAME}.tar.gz"
unless File.exist? TARBALL_NAME
  puts "Downloading glpk"
  system "curl http://ftp.gnu.org/gnu/glpk/glpk-4.44.tar.gz -O" 
end

puts "Unpacking glpk"
system "tar -xzf #{TARBALL_NAME}"

Dir.chdir(ROOT_DIR.join(PROG_NAME).to_s)

puts "Configuring..."
system "./configure --prefix=#{INSTALL_DIR}"

puts "Compiling..."
system "make"

puts "Installing to ..."
system "make install"
