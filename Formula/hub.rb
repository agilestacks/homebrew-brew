class Hub < Formula
    desc "Agile Stacks cli tool to manage stacks"
    homepage "https://www.agilestacks.com/"
    url "https://controlplane.agilestacks.io/dist/hub-cli/hub.darwin_amd64"
    version "0.0.1"
    sha256 "f22734ce2a26b68f5212ff84fc12aa7c770925444997af8511014e134e11c897"
    license "MIT"
    head "https://github.com/agilestacks/hub"


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