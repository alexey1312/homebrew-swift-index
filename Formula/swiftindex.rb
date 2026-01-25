class Swiftindex < Formula
  desc "Swift-native semantic code search for AI coding assistants via MCP"
  homepage "https://github.com/alexey1312/swift-index"
  version "0.2.4"
  license "MIT"

  on_macos do
    url "https://github.com/alexey1312/swift-index/releases/download/v#{version}/swiftindex-macos.zip"
    sha256 "1264400275d4a0bbf2bfb880372702d408ba89be50a5844b3719965e828b7fb1"

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
