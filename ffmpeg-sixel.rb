require "formula"

class FfmpegSixel < Formula
  homepage "https://ffmpeg.org/"
  head "https://github.com/saitoha/FFmpeg-SIXEL.git"

  depends_on "pkg-config" => :build

  depends_on "yasm" => :build

  depends_on "libquvi"
  depends_on "libsixel"

  conflicts_with "ffmpeg", :because => "ffmpeg and ffmpeg-sixel install the same binaries."

  def install
    args = ["--prefix=#{prefix}",
            "--enable-libquvi",
            "--enable-libsixel",
            "--cc=#{ENV.cc}",
           ]

    # For 32-bit compilation under gcc 4.2, see:
    # http://trac.macports.org/ticket/20938#comment:22
    ENV.append_to_cflags "-mdynamic-no-pic" if Hardware.is_32_bit? && Hardware::CPU.intel? && ENV.compiler == :clang

    ENV["GIT_DIR"] = cached_download/".git" if build.head?

    system "./configure", *args

    if MacOS.prefer_64_bit?
      inreplace "config.mak" do |s|
        shflags = s.get_make_var "SHFLAGS"
        if shflags.gsub!(" -Wl,-read_only_relocs,suppress", "")
          s.change_make_var! "SHFLAGS", shflags
        end
      end
    end

    system "make", "install"
  end
end
