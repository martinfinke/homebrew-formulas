class Faust < Formula
  homepage "http://faust.grame.fr"
  url "https://downloads.sourceforge.net/project/faudiostream/faust-0.9.67.zip"
  sha1 "dce57ff33a8a35b23ab029946ae5c920c401b7f5"

  def install
    system "sed -i.bu 's|^PREFIX ?= /usr/local$|PREFIX ?= #{prefix}|' Makefile && rm Makefile.bu"
    system "make"
    system "make", "install"
  end

  test do
    system "#{bin}/faust", "-v"
  end
end
