class Hub < Formula
    desc "Hub CLI is stack composition and lifecycle tool"
    homepage "https://superhub.io/"
    url "https://controlplane.agilestacks.io/dist/hub-cli/hub.darwin_amd64"
    version "2020-12-09"
    license "GPLv3"
    head "https://github.com/agilestacks/hub"
    sha256 "75ebf363e7b18b773a443245e17d1751819cbcb7f5acc5a3480a4c9df11244b3"


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
