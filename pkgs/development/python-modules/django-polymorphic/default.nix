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
    hash = "1d47cac7f68c75101af740e8f7bab3208738ac41aec2d710c62c46d36dc459f3";
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
