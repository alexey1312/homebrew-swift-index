class Swiftindex < Formula
  desc "Swift-native semantic code search for AI coding assistants via MCP"
  homepage "https://github.com/alexey1312/swift-index"
  version "0.3.0"
  license "MIT"

  on_macos do
    url "https://github.com/alexey1312/swift-index/releases/download/v#{version}/swiftindex-macos.zip"
    sha256 "67dd926c16b1447d8314d0106332a3dd3bb66d05e897de9800e69cfa2597f081"

    depends_on macos: :sonoma
  end

  def install
    # Install binary and metallibs together in libexec
    # (metallibs must be in same directory as binary for MLX to find them)
    libexec.install "swiftindex", "default.metallib", "mlx.metallib"
    # Symlink only the binary to bin
    bin.install_symlink libexec/"swiftindex"
  end

  def caveats
    <<~EOS
      Quick start:
        swiftindex index .              # Index current directory
        swiftindex search "auth flow"   # Search your codebase

      MCP integration:
        swiftindex install-claude-code  # Configure Claude Code
        swiftindex install-cursor       # Configure Cursor
        swiftindex install-codex        # Configure Codex

      Configuration:
        Create .swiftindex.toml in your project root for custom settings.
    EOS
  end

  test do
    assert_match "swiftindex", shell_output("#{bin}/swiftindex --version")
  end
end
