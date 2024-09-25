{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  django,
  setuptools,
  python,
  poetry-core,
  strawberry-graphql,
}:

buildPythonPackage rec {
  powner = "strawberry-graphql";
  pname = "strawberry-django";
  version = "0.48.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = powner;
    repo = pname;
    rev = "v${version}";
    sha256 = "09fa38b9f493f7e64352ce797a89f322e5d30e77963eb24422e7b29a85b8c244";
  };

  build-system = [ poetry-core ];

  propagatedBuildInputs = [
    django
    strawberry-graphql
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
