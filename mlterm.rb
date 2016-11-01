require "formula"

class Mlterm < Formula
  homepage "http://mlterm.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/mlterm/01release/mlterm-3.3.8/mlterm-3.3.8.tar.gz"
  head "https://bitbucket.org/arakiken/mlterm", :using => :hg
  sha256 "314489685993aa4fe1fc08950226e93936df6773e2cadaf889b1f76f7d7f1721"

  depends_on :x11
  depends_on 'gdk-pixbuf'
  depends_on 'cairo'
  depends_on 'gtk+'
  depends_on 'pkg-config' => :build

  def install
    system "./configure", "--prefix=#{prefix}", "--with-imagelib=gdk-pixbuf", "--with-type-engines=cairo", "--with-x"
    system "make"
    system "make", "install"
  end
end
