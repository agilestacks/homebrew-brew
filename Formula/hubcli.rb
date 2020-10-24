class HubCli < Formula
    desc "CLI to manage your deployments"
    homepage "https://www.superhub.io/"
    url "https://controlplane.agilestacks.io/dist/hub-cli/hub.darwin_amd64"
    version "0.20.10"
    sha256 "34856f5ed4c62e20d6b18c1c316143a94f03f68b51a0b768de7a4132cd5ae9c2"
    license "MIT"
    head "https://github.com/agilestacks/hub"

    conflicts_with "hub", because: "binary naming conflict"
    depends_on "git" => :recommended
    depends_on "awscli"        
    depends_on "kubectl"        
    depends_on "npm" => :optional
    depends_on "jq"  => "9.3"  
    depends_on "yq"  => "3.2"      

    def install
        chmod "+x", "hub.darwin_amd64"
        bin.install "hub.darwin_amd64" => "hub"
    end

    def post_install
        hub_home = Pathname.new "#{Dir.home}/.hub"
        unless hub_home.exist?
            system "#{Formula["hubcli"].opt_bin}/hub", "extensions", "install"
        end 
    end

    test do
        output = shell_output("#{bin}/hub version").chomp
        assert output.start_with?("Hub CLI git ")
        system "false"
    end
end
