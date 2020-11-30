class Hub < Formula
    desc "Hub CLI is stack composition and lifecycle tool"
    homepage "https://superhub.io/"
    url "https://controlplane.agilestacks.io/dist/hub-cli/hub.darwin_amd64"
    version "2020-11-24"
    license "GPLv3"
    head "https://github.com/agilestacks/hub"
    sha256 "20d7b0f3c5d48d7ee3372813622bfff7f8cb6ed9d4220327f6dac4b9bec54ac9"


    depends_on "jq"
    depends_on "npm"


    def install
        chmod "+x", "hub.darwin_amd64"
        bin.install "hub.darwin_amd64" => "hub"
    end

    def post_install
        hub_home = Pathname.new "#{Dir.home}/.hub"
        unless hub_home.exist?
            system "#{Formula["hub"].opt_bin}/hub", "extensions", "install"
        end
    end

    test do
        output = shell_output("#{bin}/hub version").chomp
        assert output.start_with?("Hub CLI git ")
        system "false"
    end
end
