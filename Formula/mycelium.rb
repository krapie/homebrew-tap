class Mycelium < Formula
  desc "Context Lifecycle TUI for AI coding-agent sessions"
  homepage "https://github.com/krapie/mycelium"
  url "https://registry.npmjs.org/@kevinprk/mycelium/-/mycelium-0.1.5.tgz"
  sha256 "2b91983e14f848cb1091cbbcf40f67ec11f85478c99bdaa27fe9cb9af12c7da6"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    # `--help` is NOT a real recognized flag (confirmed by actually running
    # it, not assumed) — mycelium's CLI has no flag parsing for it, so it
    # falls through to the unrecognized-command branch, which exits 1 for
    # any non-empty unknown command. `lang` (no args) is a real, read-only
    # subcommand — prints the current locale, touches nothing, needs no
    # TTY — and is what actually exits 0, exercising the real bin end-to-
    # end (spawns node, loads src/cli.js) rather than just checking the
    # file exists.
    assert_match "current:", shell_output("#{bin}/mycelium lang")
  end
end
