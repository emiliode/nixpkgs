{
  lib,
  buildPythonPackage,
  casttube,
  fetchPypi,
  pythonOlder,
  protobuf,
  setuptools,
  wheel,
  zeroconf,
}:

buildPythonPackage rec {
  pname = "pychromecast";
  version = "14.0.4";
  pyproject = true;

  disabled = pythonOlder "3.11";

  src = fetchPypi {
    pname = "PyChromecast";
    inherit version;
    hash = "sha256-H8BdY9sVL+b3Hv3ud9FCKNxMVemdc03kdXRVgAsfO6Q=";
  };

  postPatch = ''
    substituteInPlace pyproject.toml \
      --replace-fail "setuptools~=65.6" "setuptools" \
      --replace-fail "wheel~=0.37.1" "wheel" \
      --replace-fail "protobuf>=4.25.1" "protobuf"
  '';

  nativeBuildInputs = [
    setuptools
    wheel
  ];

  propagatedBuildInputs = [
    casttube
    protobuf
    zeroconf
  ];

  # no tests available
  doCheck = false;

  pythonImportsCheck = [ "pychromecast" ];

  meta = with lib; {
    description = "Library for Python to communicate with the Google Chromecast";
    homepage = "https://github.com/home-assistant-libs/pychromecast";
    changelog = "https://github.com/home-assistant-libs/pychromecast/releases/tag/${version}";
    license = licenses.mit;
    maintainers = with maintainers; [ abbradar ];
    platforms = platforms.unix;
  };
}
