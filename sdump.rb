require "formula"

class Sdump < Formula
  homepage "https://github.com/uobikiemukot/sdump"
  head "https://github.com/uobikiemukot/sdump.git"

  depends_on "libsixel"
  depends_on "libpng"
  depends_on "jpeg"
  depends_on "wget"
  depends_on "mupdf"

  def install
    system "make"
    bin.install "sdump"
    bin.install "scripts/spdf"
    bin.install "scripts/surl"
    bin.install "scripts/sviewer"
  end
end
