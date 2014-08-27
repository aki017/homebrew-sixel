require "formula"

class Libsixel < Formula
  homepage "http://saitoha.github.com/libsixel"
  head "https://github.com/saitoha/libsixel.git"

  depends_on 'gdk-pixbuf' => :optional
  depends_on 'gd' => :optional
  depends_on "pkg-config" => :build

  def install
    args = %W[
      --prefix=#{prefix}
      --with-libcurl
    ]

    args << "--with-gdk-pixbuf2" if build.with? 'gdk-pixbuf'
    args << "--with-gd" if build.with? 'gd'

    system "./configure", *args
    system "make"
    system "make", "install"
  end
end
