{ buildPythonApplication,
fetchFromGitHub,
setuptools,
pandocfilters,
lib
 }:
buildPythonApplication rec {
    pname = "pandoc-latex-environment";
    version = "1.1.6.2";
    format = "pyproject";

    src = fetchFromGitHub {
      owner = "chdemko";
      repo = "pandoc-latex-environment";
      rev = "2c5ce1bfb91c316d4259bee6d4dd76814167fa11";
      sha256 = "vxDAeXdxxswhNgYrgo88YuXDtSvxJy91h2FA8HkbNd4=";
    };

    nativeBuildInputs = [
      setuptools
    ];

    propagatedBuildInputs = [
      pandocfilters
    ];

    postPatch = ''
      substituteInPlace setup.py \
          --replace "setup_requires=['pytest-runner']," "setup_requires=[],"
    '';

    meta = with lib; {
      homepage = "https://github.com/chdemko/pandoc-latex-environment";
      description = "Pandoc filter for adding LaTeX environement on specific div";
      license = licenses.bsd3;
      maintainers = with maintainers; [ patrickaldis ];
    };
}
