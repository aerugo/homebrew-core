class Prelude < Formula
  desc "Tool to generate prompts containing file tree and concatenated file contents"
  homepage "https://github.com/aerugo/prelude"
  url "https://github.com/aerugo/prelude/archive/refs/tags/v0.3.tar.gz"
  sha256 "ba1cc4ec19375707603da30ce5dec516e6171593f649b7d26fe327cb608c0f20"
  license "MIT"

  depends_on "tree"

  def install
    bin.install "prelude"
  end

  test do
    system "#{bin}/prelude", "--help"
  end
end
