
{ buildPythonApplication,
fetchFromGitHub,
setuptools,
pandocfilters,
lib,
panflute
 }:
buildPythonApplication {
    pname = "pandoc-latex-admonition";
    version = "1.1.6.2";
    format = "pyproject";

    src = fetchFromGitHub {
      owner = "chdemko";
      repo = "pandoc-latex-admonition";
      rev = "2654ce4cfbfd1e21b77b5320ed2042e2f23d89ed";
      sha256 = "csjquE9REfsAzPnKkIg7c1xd6NvmELNEgyfREgeCxls=";
    };

    nativeBuildInputs = [
      setuptools
    ];

    propagatedBuildInputs = [
      pandocfilters
      panflute
    ];

    postPatch = ''
      substituteInPlace setup.py \
          --replace "setup_requires=['pytest-runner']," "setup_requires=[],"
    '';

    meta = with lib; {
      homepage = "https://github.com/chdemko/pandoc-latex-admonition";
      description = "A pandoc filter for setting admonition on specific div or codeblock elements";
      license = licenses.bsd3;
      maintainers = with maintainers; [ patrickaldis ];
    };
}