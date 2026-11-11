class Cappy < Formula
  desc "Record meeting audio and mic as separate tracks, then transcribe and summarize"
  homepage "https://github.com/yteraoka/cappy"
  url "https://github.com/yteraoka/cappy/releases/download/v0.2.0/cappy-0.2.0-macos-arm64.zip"
  sha256 "5e8da57e358fe9318fa799f6883becdb059e40e75d3859c5f1a8433335382a69"
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
      Run `cappy doctor` to check permissions, authentication and settings.
      Set CAPPY_LANG=ja to show messages in Japanese.
    EOS
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/cappy --version").strip
    assert_match "#compdef cappy", shell_output("#{bin}/cappy completion zsh")
  end
end
