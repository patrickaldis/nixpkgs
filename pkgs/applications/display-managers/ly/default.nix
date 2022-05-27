{ stdenv, lib, fetchFromGitHub, git, linux-pam, libxcb }:

stdenv.mkDerivation rec {
  pname = "ly";
  version = "0.6.0";

  src = fetchFromGitHub {
    owner = "fairyglade";
    repo = "ly";
    rev = "v${version}";
    hash = "sha256-78XD6DK9aQi8hITWJWnFZ3U9zWTcuw3vtRiU3Lhu7O4=";
    fetchSubmodules = true;
  };

  hardeningDisable = [ "all" ];
  nativeBuildInputs = [ git ];
  buildInputs = [ libxcb linux-pam ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/etc/ly

    # We won't be installing pam neither the systemd service.
    # We'd rather rely on creating a module and use
    # security.pam.services and systemd.services.ly.
    cp res/config.ini $out/etc/ly/
    cp res/xsetup.sh $out/etc/ly/
    cp res/wsetup.sh $out/etc/ly/
    cp -r res/lang $out/etc/ly/
    install -Dm555 -t $out/bin bin/ly

    runHook postInstall
  '';

  meta = with lib; {
    description = "TUI display manager";
    license = licenses.wtfpl;
    homepage = "https://github.com/fairyglade/ly";
    maintainers = [ maintainers.vidister ];
    platforms = platforms.linux;
  };
}
