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
    sha256 = "12y3chxhqxk2yxin055f0f45nabj0s8hil12hw0lwzlbax6k9ss6";
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
