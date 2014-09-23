require 'formula'

class W3mSixel < Formula
  homepage 'https://bitbucket.org/arakiken/w3m'
  head 'https://bitbucket.org/arakiken/w3m', :using => :hg, :branch => 'remoteimg'

  depends_on 'bdw-gc'
  depends_on 'libsixel' => ['with-gdk-pixbuf']

  conflicts_with "w3m", :because => "w3m and w3m-sixel install the same binaries."

  def install
    system "./configure", "--prefix=#{prefix}", "--enable-image", "--with-imagelib="
    system "make install"
  end
end
