require "formula"

class Rgbds < Formula
  homepage "https://github.com/bentley/rgbds"
  url "https://github.com/bentley/rgbds/releases/download/v0.2.0/rgbds-0.2.0.tar.gz"
  sha1 "e87b017d5c0c5addcd9f539a16e16899b2e6748d"

  head "https://github.com/bentley/rgbds.git"

  bottle do
    cellar :any
    sha1 "033923dc3ed2c549519448845d30fabefeb83bf1" => :yosemite
    sha1 "9cae6061f1fce0ed5981d9ed0a7fd2885d66334f" => :mavericks
    sha1 "ca4bad2a5be8b05e0c30dfb87569de1c6a2fcb07" => :mountain_lion
  end

  # patch do
  #   url "https://dl.dropboxusercontent.com/u/6617733/rgbds-homebrew-noreturn-fix.diff"
  #   sha1 "8c624432b0c650a0644810befb0b572e4599b3c6"
  # end

  patch <<-eos
    diff --git a/src/extern/err.c b/src/extern/err.c
    index 1b27284..a00db08 100644
    --- a/src/extern/err.c
    +++ b/src/extern/err.c
    @@ -30,6 +30,8 @@
     char *__progname;
     #endif
     
    +#define _Noreturn 
    +
     void rgbds_vwarn(const char *fmt, va_list ap)
     {
      fprintf (stderr, "%s: ", __progname);
  eos

  def install
    system "make"
    system "make", "install", "PREFIX=#{prefix}", "MANPREFIX=#{man}"
  end

  test do
    (testpath/"source.asm").write <<-EOS.undent
      SECTION "Org $100",HOME[$100]
      nop
      jp begin
      begin:
        ld sp, $ffff
        ld a, $1
        ld b, a
        add a, b
    EOS
    system "#{bin}/rgbasm", "source.asm"
  end
end
