require "formula"

class FfmpegSixel < Formula
  homepage "https://ffmpeg.org/"
  head "https://github.com/saitoha/FFmpeg-SIXEL.git"

  depends_on "pkg-config" => :build

  depends_on "yasm" => :build

  depends_on "libquvi"
  depends_on "libsixel"

  conflicts_with "ffmpeg", :because => "ffmpeg and ffmpeg-sixel install the same binaries."

  patch :DATA

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

__END__
--- a/configure
+++ b/configure
@@ -4746,7 +4746,7 @@ enabled libcelt           && require libcelt celt/celt.h celt_decode -lcelt0 &&
                              { check_lib celt/celt.h celt_decoder_create_custom -lcelt0 ||
                                die "ERROR: libcelt must be installed and version must be >= 0.11.0."; }
 enabled libcaca           && require_pkg_config caca caca.h caca_create_canvas
-enabled libsixel          && require_pkg_config libsixel sixel.h LibSixel_LSImageToSixel
+enabled libsixel          && require_pkg_config libsixel sixel.h sixel_encode
 enabled libfaac           && require2 libfaac "stdint.h faac.h" faacEncGetVersion -lfaac
 enabled libfdk_aac        && require libfdk_aac fdk-aac/aacenc_lib.h aacEncOpen -lfdk-aac
 flite_libs="-lflite_cmu_time_awb -lflite_cmu_us_awb -lflite_cmu_us_kal -lflite_cmu_us_kal16 -lflite_cmu_us_rms -lflite_cmu_us_slt -lflite_usenglish -lflite_cmulex -lflite"
@@ -4775,7 +4775,7 @@ enabled libquvi           && require_pkg_config libquvi quvi/quvi.h quvi_init
 enabled librtmp           && require_pkg_config librtmp librtmp/rtmp.h RTMP_Socket
 enabled libschroedinger   && require_pkg_config schroedinger-1.0 schroedinger/schro.h schro_init
 enabled libshine          && require_pkg_config shine shine/layer3.h shine_encode_buffer
-enabled libsixel          && require_pkg_config libsixel sixel.h LibSixel_LSImageToSixel
+enabled libsixel          && require_pkg_config libsixel sixel.h sixel_encode
 enabled libsmbclient      && { { check_pkg_config smbclient libsmbclient.h smbc_init &&
                                  require_pkg_config smbclient libsmbclient.h smbc_init; } ||
                                  require smbclient libsmbclient.h smbc_init -lsmbclient; }
