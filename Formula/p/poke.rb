class Poke < Formula
  desc "Extensible editor for structured binary data"
  homepage "https://jemarch.net/poke"
  url "https://ftp.gnu.org/gnu/poke/poke-4.2.tar.gz"
  sha256 "8aaf36e61e367a53140ea40e2559e9ec512e779c42bee34e7ac24b34ba119bde"
  license "GPL-3.0-or-later"

  bottle do
    sha256 arm64_sonoma:   "3d9297de5d81573ebd887c0cc4cd60708035243ffa76b4b55c017d209990d1f0"
    sha256 arm64_ventura:  "9f7f2774471a422cf1e3d5e88c47a36e74464ad91ea3f5df85ac116f638bb6bc"
    sha256 arm64_monterey: "47bfef8768ab688bf91baa185ded5e4a1a472a1cf9fe40f915c944dd7a31ac0a"
    sha256 sonoma:         "0bee499d3c558c3e0356a8213253ca174d5e2df2ae652500b0fc1dd48cb81976"
    sha256 ventura:        "596a59a1c0963fefafaae893abe5079ddaa406f8bc76bb37e9d059b7a0b0b0d0"
    sha256 monterey:       "a27a1107d42548ba66f4b5a5c74cb5550d7696f0f7f3e4b97ba117eacbcbf065"
    sha256 x86_64_linux:   "6187cd9c0982529ead1c5731fd77dbe30115053b96fbd9a3a6858b9c47bda753"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "help2man" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build

  depends_on "bdw-gc"
  depends_on "gettext"
  depends_on "readline"

  uses_from_macos "ncurses"

  def install
    system "./configure", *std_configure_args, "--disable-silent-rules", "--with-lispdir=#{elisp}"
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"test.pk").write <<~EOS
      .file #{bin}/poke
      dump :size 4#B :ruler 0 :ascii 0
      .exit
    EOS
    if OS.mac?
      assert_match "00000000: cffa edfe", shell_output("#{bin}/poke --quiet -s test.pk")
    else
      assert_match "00000000: 7f45 4c46", shell_output("#{bin}/poke --quiet -s test.pk")
    end
  end
end
