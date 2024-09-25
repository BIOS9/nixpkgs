{ lib
, fetchFromGitHub
, python3
, version
, hash
, plugins ? ps: []
, extraPatches ? []
, tests ? {}
, maintainers ? []
, eol ? false
}:
  let
    py = python3.override {
      self = py;
      packageOverrides = self: super: {
        django = super.django_5;
      };
    };

   # py = python3 // {
   #   packageOverrides = self: super: {
   #     pkgs = python3.pkgs.overrideScope (self: super: {
   #       django = super.django_5;
   #     });
   #   };
   # };
    extraBuildInputs = plugins py.pkgs;
  in
  py.pkgs.buildPythonApplication rec {
      pname = "netbox";
      inherit version;

      format = "other";

      src = fetchFromGitHub {
        owner = "netbox-community";
        repo = pname;
        rev = "refs/tags/v${version}";
        inherit hash;
      };

      patches = extraPatches;

      propagatedBuildInputs = with py.pkgs; [
        bleach
        boto3
        django
        django-cors-headers
        django-debug-toolbar
        django-filter
        django-graphiql-debug-toolbar
        django-htmx
        django-mptt
        django-pglocks
        django-prometheus
        django-redis
        django-rq
        django-strawberry
        django-tables2
        django-taggit
        django-timezone-field
        djangorestframework
        drf-spectacular
        drf-spectacular-sidecar
        drf-yasg
        dulwich
        swagger-spec-validator # from drf-yasg[validation]
        feedparser
        graphene-django
        jinja2
        markdown
        markdown-include
        netaddr
        pillow
        psycopg
        pyyaml
        requests
        sentry-sdk
        social-auth-core
        social-auth-app-django
        svgwrite
        tablib
        jsonschema
        nh3
        tzdata
        mkdocs-material
        mkdocstrings
        gunicorn
      ] ++ extraBuildInputs;

      buildInputs = with py.pkgs; [
        mkdocs-material
        mkdocs-material-extensions
        mkdocstrings
        mkdocstrings-python
      ];

      nativeBuildInputs = [
        py.pkgs.mkdocs
      ];

      postBuild = ''
        PYTHONPATH=$PYTHONPATH:netbox/
        python -m mkdocs build
      '';

      installPhase = ''
        mkdir -p $out/opt/netbox
        cp -r . $out/opt/netbox
        chmod +x $out/opt/netbox/netbox/manage.py
        makeWrapper $out/opt/netbox/netbox/manage.py $out/bin/netbox \
          --prefix PYTHONPATH : "$PYTHONPATH"
      '';

      passthru = {
        python = py;
        # PYTHONPATH of all dependencies used by the package
        pythonPath = py.pkgs.makePythonPath propagatedBuildInputs;
        gunicorn = py.pkgs.gunicorn;
        inherit tests;
      };

      meta = {
        homepage = "https://github.com/netbox-community/netbox";
        description = "IP address management (IPAM) and data center infrastructure management (DCIM) tool";
        mainProgram = "netbox";
        license = lib.licenses.asl20;
        knownVulnerabilities = (lib.optional eol "Netbox version ${version} is EOL; please upgrade by following the current release notes instructions.");
        # Warning:
        # Notice the missing `lib` in the inherit: it is using this function argument rather than a `with lib;` argument.
        # If you replace this by `with lib;`, pay attention it does not inherit all maintainers in nixpkgs.
        inherit maintainers;
      };
    }
