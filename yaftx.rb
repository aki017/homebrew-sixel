require "formula"

class Yaftx < Formula
  homepage "http://uobikiemukot.github.io/yaft/"
  url "http://uobikiemukot.github.io/yaft/release/yaft-0.2.8.tar.gz"
  sha256 "5dfdf0c12d64638527eef4df9b17151c7c60bcc006ab976583de71a792083556"
  head "https://github.com/uobikiemukot/yaft.git"

  depends_on :x11

  patch :DATA

  def install
    ENV['LANG'] = 'en_US.UTF-8'
    system "make", "yaftx"
    bin.install 'yaftx'
  end
end

__END__
--- a/makefile
+++ b/makefile
@@ -4,8 +4,8 @@ CC ?= gcc
 CFLAGS  ?= -std=c99 -pedantic -Wall -Wextra -O3 -s -pipe
 LDFLAGS ?=

-XCFLAGS  ?= -std=c99 -pedantic -Wall -Wextra -I/usr/include/X11/ -O3 -s -pipe
-XLDFLAGS ?= -lX11
+XCFLAGS  ?= -std=c99 -pedantic -Wall -Wextra -I/opt/X11/include/ -O3 -s -pipe
+XLDFLAGS ?= -lX11 -L/opt/X11/lib

 HDR = color.h conf.h dcs.h draw.h function.h osc.h parse.h terminal.h util.h yaft.h glyph.h \
        fb/linux.h fb/freebsd.h fb/netbsd.h fb/openbsd.h x/x.h
