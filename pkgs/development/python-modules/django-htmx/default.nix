{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  django,
  django-js-asset,
  python,
}:

buildPythonPackage rec {
  pname = "django-htmx";
  powner = "adamchainz";
  version = "1.19.0";
  format = "setuptools";

  src = fetchFromGitHub {
    owner = powner;
    repo = pname;
    rev = version;
    sha256 = "9d2bad12b52415a7ca8c1b30842f8bae7dfd32009b0abcedb40c756beaadd6ca";
  };

  propagatedBuildInputs = [
    django
    django-js-asset
  ];

  pythonImportsCheck = [ "htmx" ];

  checkPhase = ''
    runHook preCheck
    ${python.interpreter} tests/manage.py test
    runHook postCheck
  '';

  meta = with lib; {
    description = "Extensions for using Django with htmx.";
    homepage = "https://github.com/adamchainz/django-htmx";
    maintainers = with maintainers; [ BIOS9 ];
    license = with licenses; [ mit ];
  };
}
