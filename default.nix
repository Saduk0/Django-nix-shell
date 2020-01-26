
with import <nixpkgs> {};
  ( let
      my_django = python37.pkgs.buildPythonPackage rec {

        pname = "Django";
        version = "3.0.2";

        /* disabled = !isPy3k; */

        src = python37.pkgs.fetchPypi {
          inherit pname version;
          sha256 = "8c3575f81e11390893860d97e1e0154c47512f180ea55bd84ce8fa69ba8051ca";
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
