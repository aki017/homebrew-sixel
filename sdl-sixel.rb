require "formula"

class SdlSixel < Formula
  homepage "https://www.libsdl.org/"
  head "https://github.com/saitoha/SDL1.2-SIXEL.git"

  depends_on "pkg-config" => :build

  depends_on "libsixel"

  conflicts_with "sdl", :because => "sdl and sdl-sixel install the same binaries."

  def install
    args = ["--prefix=#{prefix}",
            "--enable-video-sixel",
            "--without-x",
           ]

    system "./configure", *args

    system "make", "install"
  end
end
