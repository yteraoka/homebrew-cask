class Cappy < Formula
  desc "Record meeting audio and mic as separate tracks, then transcribe and summarize"
  homepage "https://github.com/yteraoka/cappy"
  url "https://github.com/yteraoka/cappy/releases/download/v0.9.1/cappy-0.9.1-macos-arm64.zip"
  sha256 "36b6342052b4f8cad4ed157d679d8ec3e2a9df84f1ecc391f3f4cec9c8bb75db"
  license "MIT"

  depends_on arch: :arm64
  depends_on macos: :sequoia

  def install
    bin.install "cappy"
    # Install the output of `cappy completion bash` / `cappy completion zsh` as completion scripts
    generate_completions_from_executable(bin/"cappy", "completion", shells: [:bash, :zsh])
  end

  def caveats
    <<~EOS
      The first recording asks the terminal app you run cappy from for
      the "System Audio Recording" and "Microphone" permissions.
      Run `cappy init` to create the config file interactively, and
      `cappy doctor` to check permissions, authentication and settings.
      Set CAPPY_LANG=ja to show messages in Japanese.
    EOS
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/cappy --version").strip
    assert_match "#compdef cappy", shell_output("#{bin}/cappy completion zsh")
  end
end
