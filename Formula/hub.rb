class Hub < Formula
    desc "Hub CLI is stack composition and lifecycle tool"
    homepage "https://superhub.io/"
    url "https://github.com/agilestacks/hub/releases/download/v1.0.2/hub.darwin_amd64"
    version "v1.0.2"
    license "GPLv3"
    head "https://github.com/agilestacks/hub"
    sha256 "30a31e8aab86b7defe15d8cb73befb0a8b534ab8a1865583e92ccedfd08d52a5"


    depends_on "jq"
    depends_on "yq"
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
