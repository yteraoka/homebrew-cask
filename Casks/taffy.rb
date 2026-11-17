cask "taffy" do
  version "0.1.0"
  sha256 "677eac6cf8bd14c93329c39a910c3ac26ab0ca901e85241c851e27e2d585622c"

  url "https://github.com/yteraoka/taffy/releases/download/v#{version}/Taffy-#{version}-macos-universal.zip"
  name "Taffy"
  desc "Search tabs across browsers and switch to them"
  homepage "https://github.com/yteraoka/taffy"

  livecheck do
    skip "Auto-generated on release."
  end

  depends_on macos: :ventura

  app "Taffy.app"

  # ad-hoc 署名で公証していないため、quarantine 属性を外して Gatekeeper に止められないようにする
  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{appdir}}/Taffy.app"],
        must_succeed: false
  end

  uninstall quit: "com.github.yteraoka.taffy"

  zap trash: "~/Library/Preferences/com.github.yteraoka.taffy.plist"

  caveats <<~EOS
    Taffy runs in the menu bar. Press Shift-Command-Space to search tabs.
    The first time it reads tabs, macOS asks to allow Taffy to control each browser.
  EOS
end
