{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  django,
  setuptools,
  python,
}:

buildPythonPackage rec {
  pname = "strawberry-graphql";
  version = "0.48.0";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = pname;
    repo = pname;
    rev = version;
    sha256 = "9d2bad12b52415a7ca8c1b30842f8bae7dfd32009b0abcedb40c756beaadd6ca";
  };

  propagatedBuildInputs = [
    django
    setuptools
  ];

#  pythonImportsCheck = [ "htmx" ];

#  checkPhase = ''
#    runHook preCheck
#    ${python.interpreter} tests/manage.py test
#    runHook postCheck
#  '';

  meta = with lib; {
    description = "Provides powerful tools to generate GraphQL types, queries, mutations and resolvers from Django models.";
    homepage = "https://github.com/strawberry-graphql/strawberry-django";
    maintainers = with maintainers; [ BIOS9 ];
    license = with licenses; [ mit ];
  };
}
