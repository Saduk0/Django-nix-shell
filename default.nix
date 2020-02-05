
with import <nixpkgs> {};
  ( let
      my_django = python37.pkgs.buildPythonPackage rec {

        pname = "Django";
        version = "3.0.3";

        /* disabled = !isPy3k; */

        src = python37.pkgs.fetchPypi {
          inherit pname version;
          sha256 = "2f1ba1db8648484dd5c238fb62504777b7ad090c81c5f1fd8d5eb5ec21b5f283";
        };

        propagatedBuildInputs = with python3.pkgs;
          [ sqlparse asgiref pytz ];

        # too complicated to setup
        doCheck = false;

        preConfigure = ''
          export DJANGO_SETTINGS_MODULE=mysite.settings
        '';

        meta = with stdenv.lib; {
          description = "A high-level Python Web framework";
          homepage = https://www.djangoproject.com/;
          license = licenses.bsd3;
          maintainers = with maintainers; [ georgewhewell lsix ];
        };
      };
    in python37.withPackages (ps: [my_django])
    ).env
