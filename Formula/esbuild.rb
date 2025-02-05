require "language/node"

class Esbuild < Formula
  desc "Extremely fast JavaScript bundler and minifier"
  homepage "https://esbuild.github.io/"
  url "https://registry.npmjs.org/esbuild/-/esbuild-0.16.15.tgz"
  sha256 "66684beb9f16c029ef09129af7dc3d9b079f5536b42c3b4eff76aadbbd54f0a0"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "dd2ffa319535a3a47065cc9bb329f7ea7ff15f7c4690dd5b3c9da209f5ee740f"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "dd2ffa319535a3a47065cc9bb329f7ea7ff15f7c4690dd5b3c9da209f5ee740f"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "dd2ffa319535a3a47065cc9bb329f7ea7ff15f7c4690dd5b3c9da209f5ee740f"
    sha256 cellar: :any_skip_relocation, ventura:        "78aff25c534d4b31a14aeabe287576d4bfc03c3a24d1d2e339581d9de32bccb7"
    sha256 cellar: :any_skip_relocation, monterey:       "78aff25c534d4b31a14aeabe287576d4bfc03c3a24d1d2e339581d9de32bccb7"
    sha256 cellar: :any_skip_relocation, big_sur:        "78aff25c534d4b31a14aeabe287576d4bfc03c3a24d1d2e339581d9de32bccb7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "82dbcc9e3ef342b241338c31f8e0894caeaf2002aa2bcd1189cb2e82c6197306"
  end

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    (testpath/"app.jsx").write <<~EOS
      import * as React from 'react'
      import * as Server from 'react-dom/server'

      let Greet = () => <h1>Hello, world!</h1>
      console.log(Server.renderToString(<Greet />))
    EOS

    system Formula["node"].libexec/"bin/npm", "install", "react", "react-dom"
    system bin/"esbuild", "app.jsx", "--bundle", "--outfile=out.js"

    assert_equal "<h1>Hello, world!</h1>\n", shell_output("node out.js")
  end
end
