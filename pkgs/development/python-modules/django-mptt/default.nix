{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  django,
  django-js-asset,
  python,
}:

buildPythonPackage rec {
  pname = "django-mptt";
  version = "0.16";
  pyproject = true;

  src = fetchFromGitHub {
    owner = pname;
    repo = pname;
    rev = version;
    sha256 = "bd69d7296cda6b9016a0d68873c340d41da69f32974658909a2e5576b44c69d1";
  };

  propagatedBuildInputs = [
    django
    django-js-asset
  ];

  pythonImportsCheck = [ "mptt" ];

  checkPhase = ''
    runHook preCheck
    ${python.interpreter} tests/manage.py test
    runHook postCheck
  '';

  meta = with lib; {
    description = "Utilities for implementing a modified pre-order traversal tree in Django";
    homepage = "https://github.com/django-mptt/django-mptt";
    maintainers = with maintainers; [ hexa ];
    license = with licenses; [ mit ];
  };
}
