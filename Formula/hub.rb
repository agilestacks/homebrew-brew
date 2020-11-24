class Hub < Formula
    desc "Hub CLI is stack composition and lifecycle tool"
    homepage "https://superhub.io/"
    url "https://controlplane.agilestacks.io/dist/hub-cli/hub.darwin_amd64"
    version "2020-11-24"
    license "GPLv3"
    head "https://github.com/agilestacks/hub"
    sha256 "47a1b510592a2e15bf56df2366166d460639afc4e84c5e01b0010d95905b7760"


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
