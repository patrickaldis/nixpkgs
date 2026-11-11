{
  lib,
  fetchFromGitHub,
  buildGoModule,
  git,
  gnupg,
  less,
  openssh,
  versionCheckHook,
  nix-update-script,
}:

buildGoModule (finalAttrs: {
  pname = "gittuf";
  version = "0.17.0";

  src = fetchFromGitHub {
    owner = "gittuf";
    repo = "gittuf";
    tag = "v${finalAttrs.version}";
    hash = "sha256-kx9/BEWK0bK//jmwfHgpK8hSk0urLHCHq/pfzLEVuAY=";
  };

  vendorHash = "sha256-gUfZLxN5eZBMu6Vx2Eg+b5xse6Y0uA6h7QqJC71VRDM=";

  ldflags = [ "-X github.com/gittuf/gittuf/internal/version.gitVersion=${finalAttrs.version}" ];

  __structuredAttrs = true;

  nativeCheckInputs = [
    git
    gnupg
    less
    openssh
  ];
  checkFlags = [ "-skip=TestLoadRepository|TestSSH" ];

  postInstall = "rm $out/bin/cli"; # remove gendoc helper binary

  nativeInstallCheckInputs = [ versionCheckHook ];
  versionCheckProgramArg = "version";
  doInstallCheck = true;

  passthru.updateScript = nix-update-script { };

  meta = {
    changelog = "https://github.com/gittuf/gittuf/blob/${finalAttrs.src.tag}/CHANGELOG.md";
    description = "Security layer for Git repositories";
    homepage = "https://gittuf.dev";
    license = lib.licenses.asl20;
    mainProgram = "gittuf";
    maintainers = with lib.maintainers; [
      flandweber
      anish
    ];
  };
})
