{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  python,
  django,
  dj-database-url,
}:

buildPythonPackage rec {
  pname = "django-polymorphic";
  version = "4.0.0a";
  format = "setuptools";

  src = fetchFromGitHub {
    owner = "django-polymorphic";
    repo = "django-polymorphic";
    rev = "v${version}";
    hash = "sha256-JJY+FoMPSgWuSsNIas2JedGJpdm6RfPE3E1VIjGuXIc=";
  };

  propagatedBuildInputs = [ django ];

  nativeCheckInputs = [ dj-database-url ];

  checkPhase = ''
    ${python.interpreter} runtests.py
  '';

  pythonImportsCheck = [ "polymorphic" ];

  meta = with lib; {
    homepage = "https://github.com/django-polymorphic/django-polymorphic";
    description = "Improved Django model inheritance with automatic downcasting";
    license = licenses.bsd3;
    maintainers = [ ];
  };
}
