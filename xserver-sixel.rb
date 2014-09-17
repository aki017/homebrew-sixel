require "formula"

class XserverSixel < Formula
  homepage "http://cgit.freedesktop.org/xorg/xserver"
  head "https://github.com/saitoha/xserver-SIXEL.git", :branch => "sixel-for-XQuartz"

  depends_on "pkg-config" => :build
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  depends_on :x11
  depends_on "pixman"
  depends_on "libsixel"

  ENV["ACLOCAL"] = "aclocal -I #{MacOS::X11.share}/aclocal"
  ENV["PKG_CONFIG_PATH"] = "#{HOMEBREW_PREFIX}/lib/pkgconfig:#{MacOS::X11.lib}/pkgconfig"

  def install
    args = ["--prefix=#{prefix}",
            "--with-xkb-path=#{MacOS::X11.share}/X11/xkb",
            "--with-xkb-bin-directory=#{MacOS::X11.bin}",
            "--disable-xorg",
            "--disable-dmx",
            "--disable-xvfb",
            "--disable-xnest",
            "--disable-xwin",
            "--disable-xephyr",
            "--disable-xfake",
            "--disable-xfbdev",
            "--disable-glx",
            "--disable-unit-tests",
            "--disable-xf86vidmode",
            "--disable-xquartz",
            "--disable-docs",
            "--enable-xsixel",
            "--enable-kdrive",
            "--enable-kdrive-kbd",
            "--enable-kdrive-mouse",
            "--enable-kdrive-evdev",
           ]

    system "./autogen.sh"
    system "./configure", *args
    system "make", "install"
  end
end
