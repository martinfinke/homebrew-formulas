require "formula"

class Ndstool < Formula
  homepage "http://www.darkfader.net/ds/"
  url "git://git.code.sf.net/p/devkitpro/ndstool"
  sha1 "94a927bc6b062c619f6d1b9d1c3db9dd92b33125"
  version "1.50.1"

  depends_on "autoconf" => :build
  depends_on "automake" => :build

  def install
    system "sh autogen.sh"
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/ndstool", "-?"
  end
end
